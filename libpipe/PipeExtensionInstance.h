//======================================================================================================================
/*
	Copyright (c) since 2015 - Paul Freund (freund.paul@lvl3.org)
	
	Permission is hereby granted, free of charge, to any person
	obtaining a copy of this software and associated documentation
	files (the "Software"), to deal in the Software without
	restriction, including without limitation the rights to use,
	copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the
	Software is furnished to do so, subject to the following
	conditions:
	
	The above copyright notice and this permission notice shall be
	included in all copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
	OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
	OTHER DEALINGS IN THE SOFTWARE.
*/
//======================================================================================================================

#pragma once

//======================================================================================================================

#include "PipeExtensionInterface.h"

//======================================================================================================================

const tstring NamePipeExtensionSetErrorCallback             = _T("PipeExtensionSetErrorCallback");
const tstring NamePipeExtensionSetPath                      = _T("PipeExtensionSetPath");
const tstring NamePipeExtensionGetServiceTypes              = _T("PipeExtensionGetServiceTypes");
const tstring NamePipeExtensionServiceCreate                = _T("PipeExtensionServiceCreate");
const tstring NamePipeExtensionServiceDestroy               = _T("PipeExtensionServiceDestroy");
const tstring NamePipeExtensionProcess                      = _T("PipeExtensionProcess");
const tstring NamePipeExtensionServicePush                  = _T("PipeExtensionServicePush");
const tstring NamePipeExtensionServicePull                  = _T("PipeExtensionServicePull");

typedef void(*FktPipeExtensionSetErrorCallback)             (PipeExtensionCbStr);
typedef void(*FktPipeExtensionSetPath)                      (PipeExtensionStr);
typedef void(*FktPipeExtensionGetServiceTypes)              (PipeExtensionCbContext, PipeExtensionCbStr);
typedef void(*FktPipeExtensionServiceCreate)                (PipeExtensionStr, PipeExtensionStr, PipeExtensionStr, HPipeExtensionService*);
typedef void(*FktPipeExtensionServiceDestroy)               (HPipeExtensionService);
typedef void(*FktPipeExtensionProcess)                      ();
typedef void(*FktPipeExtensionServicePush)                  (HPipeExtensionService, PipeExtensionStr);
typedef void(*FktPipeExtensionServicePull)                  (HPipeExtensionService, PipeExtensionCbContext, PipeExtensionCbStr);

//======================================================================================================================

struct PipeExtensionFunctions {
	FktPipeExtensionSetErrorCallback            fktPipeExtensionSetErrorCallback            = nullptr;
	FktPipeExtensionSetPath                     fktPipeExtensionSetPath                     = nullptr;
	FktPipeExtensionGetServiceTypes             fktPipeExtensionGetServiceTypes             = nullptr;
	FktPipeExtensionServiceCreate               fktPipeExtensionServiceCreate               = nullptr;
	FktPipeExtensionServiceDestroy              fktPipeExtensionServiceDestroy              = nullptr;
	FktPipeExtensionProcess                     fktPipeExtensionProcess                     = nullptr;
	FktPipeExtensionServicePush                 fktPipeExtensionServicePush                 = nullptr;
	FktPipeExtensionServicePull                 fktPipeExtensionServicePull                 = nullptr;
};

//======================================================================================================================

class PipeExtensionServiceInstance : public IPipeExtensionService {
private:
	PipeExtensionFunctions _functions;
	HPipeExtensionService _instance;

public:
	PipeExtensionServiceInstance(const PipeExtensionFunctions& functions, HPipeExtensionService service) : _functions(functions), _instance(service) {}

	virtual ~PipeExtensionServiceInstance() {
		_functions.fktPipeExtensionServiceDestroy(_instance);
	}

public:
	//------------------------------------------------------------------------------------------------------------------

	virtual void push(PipeArrayPtr messages) {
		_functions.fktPipeExtensionServicePush(_instance, dumpArray(messages).c_str());
	}

	//------------------------------------------------------------------------------------------------------------------

	virtual PipeArrayPtr pull() {
		PipeArrayPtr messages;

		_functions.fktPipeExtensionServicePull(_instance, &messages, [](LibPipeCbContext context, LibPipeStr messagesData) {
			(*static_cast<PipeArrayPtr*>(context)) = parseArray(messagesData);
		});

		return messages;
	}
};

//======================================================================================================================

class PipeExtensionInstance : public IPipeExtension {
private:
	PipeExtensionFunctions _functions;

public:
	PipeExtensionInstance(const PipeExtensionFunctions& functions, const tstring& path) : _functions(functions) {
		_functions.fktPipeExtensionSetPath(path.c_str());
	}
	virtual ~PipeExtensionInstance() {}

public:
	//------------------------------------------------------------------------------------------------------------------

	virtual PipeArrayPtr serviceTypes() {
		PipeArrayPtr types;
		
		_functions.fktPipeExtensionGetServiceTypes(&types, [](PipeExtensionCbContext context, PipeExtensionStr typesData) {
			(*static_cast<PipeArrayPtr*>(context)) = parseArray(typesData);
		});

		return types;
	}

	//------------------------------------------------------------------------------------------------------------------

	virtual IPipeExtensionService* create(const tstring& serviceType, const tstring& address, const tstring& path, PipeObjectPtr settings) {
		HPipeExtensionService service = 0;

		_functions.fktPipeExtensionServiceCreate(serviceType.c_str(), address.c_str(), dumpObject(settings).c_str(), &service);

		if(service != 0)
			return new PipeExtensionServiceInstance(_functions, service);

		return nullptr;
	}

	//------------------------------------------------------------------------------------------------------------------

	virtual void destroy(IPipeExtensionService* service) {
		_functions.fktPipeExtensionServiceDestroy(service);
	}

	//------------------------------------------------------------------------------------------------------------------
	
	virtual void process() {
		_functions.fktPipeExtensionProcess();
	}

	//------------------------------------------------------------------------------------------------------------------
};

//======================================================================================================================
