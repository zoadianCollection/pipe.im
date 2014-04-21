//======================================================================================================================

#include "CommonHeader.h"
#include "LibPipe.h"

using namespace std;
using namespace Poco;
using namespace rapidjson;

//======================================================================================================================



//======================================================================================================================

void* loadExtensionSymbol(SharedLibrary& library, tstring name) {
	if(!library.hasSymbol(name))
		throw;

	void* symbol = library.getSymbol(name);
	if(symbol == nullptr)
		throw;

	return symbol;
}

void loadExtension(tstring path) {
	auto suffix = SharedLibrary::suffix();
	if(path.length() <= suffix.length())
		return;

	auto ext = path.substr(path.length() - suffix.length(), string::npos);
	if(!File(path).isFile() || ext != suffix)
		return;

	SharedLibrary library(path);
	if(!library.isLoaded())
		return;

	if(!library.hasSymbol(NamePipeExtensionGetServiceTypes))
		return;

	PipeExtensionFunctions extensionFunctions;
	try {
		extensionFunctions.fktPipeExtensionGetServiceTypes = reinterpret_cast<FktPipeExtensionGetServiceTypes>(loadExtensionSymbol(library, NamePipeExtensionGetServiceTypes));
		extensionFunctions.fktPipeExtensionServiceCreate = reinterpret_cast<FktPipeExtensionServiceCreate>(loadExtensionSymbol(library,NamePipeExtensionServiceCreate));
		extensionFunctions.fktPipeExtensionServiceDestroy = reinterpret_cast<FktPipeExtensionServiceDestroy>(loadExtensionSymbol(library,NamePipeExtensionServiceDestroy));
		extensionFunctions.fktPipeExtensionServiceSend = reinterpret_cast<FktPipeExtensionServiceSend>(loadExtensionSymbol(library,NamePipeExtensionServiceSend));
		extensionFunctions.fktPipeExtensionServiceReceive = reinterpret_cast<FktPipeExtensionServiceReceive>(loadExtensionSymbol(library,NamePipeExtensionServiceReceive));
		extensionFunctions.fktPipeExtensionServiceGetNodeChildren = reinterpret_cast<FktPipeExtensionServiceGetNodeChildren>(loadExtensionSymbol(library, NamePipeExtensionServiceGetNodeChildren));
		extensionFunctions.fktPipeExtensionServiceGetNodeInfo = reinterpret_cast<FktPipeExtensionServiceGetNodeInfo>(loadExtensionSymbol(library, NamePipeExtensionServiceGetNodeInfo));
	}
	catch(...) { return; }

	LibPipe::Extensions.push_back(PipeExtensionInstance(extensionFunctions));
}

//======================================================================================================================
LIBPIPE_ITF void LibPipeLoadExtensions(LibPipeStr path) {
	File extensionPath(path);

	if(!extensionPath.exists() || !extensionPath.canRead())
		return;

	if(extensionPath.isDirectory()) {
		for(DirectoryIterator it(extensionPath), itEnd; it != itEnd; ++it) {
			loadExtension(it->path());
		}
	}
	else {
		loadExtension(extensionPath.path());
	}
}

LIBPIPE_ITF void LibPipeGetServiceTypes(LibPipeCbContext context, LibPipeCbStr cbServiceTypes) {
	Document serviceTypes;
	serviceTypes.SetArray();
	
	for(auto&& extension : LibPipe::Extensions) {
		auto extensionServiceTypes = extension.serviceTypes();
		for(auto&& extensionServiceType : extensionServiceTypes) {
			serviceTypes.PushBack(extensionServiceType, serviceTypes.GetAllocator());
		}
	}

	StringBuffer strbuf;
	Writer<StringBuffer> writer(strbuf);
	serviceTypes.Accept(writer);
	tstring result = strbuf.GetString();

	cbServiceTypes(context, result.c_str());
}

//----------------------------------------------------------------------------------------------------------------------

LIBPIPE_ITF void LibPipeCreate(LibPipeStr path, LibPipeStr serviceTypes, HLibPipe* instance) {
	LibPipe::Instances.push_back(LibPipe(tstring(path), serviceTypes));
	(*instance) = reinterpret_cast<HLibPipe>(&LibPipe::Instances.back());
}

//----------------------------------------------------------------------------------------------------------------------

LIBPIPE_ITF void LibPipeDestroy(HLibPipe instance) {
	LibPipe* pInstance = reinterpret_cast<LibPipe*>(instance);
	for(auto it = begin(LibPipe::Instances); it != end(LibPipe::Instances); it++) {
		if(&(*it) == pInstance) {
			LibPipe::Instances.erase(it);
			return;
		}
	}
}

//----------------------------------------------------------------------------------------------------------------------

LIBPIPE_ITF void LibPipeSend(HLibPipe instance, LibPipeStr message) {
	reinterpret_cast<LibPipe*>(instance)->send(message);
}

LIBPIPE_ITF void LibPipeReceive(HLibPipe instance, LibPipeCbContext context, LibPipeCbStr cbMessages) {
	auto&& messages = reinterpret_cast<LibPipe*>(instance)->receive();
	cbMessages(context, messages.c_str());
}

//======================================================================================================================
