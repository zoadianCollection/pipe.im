//======================================================================================================================

#pragma once

//======================================================================================================================

#include "PipeExtensionInterface.h"

//======================================================================================================================

const tstring NamePipeExtensionGetServiceTypes = _T("PipeExtensionGetServiceTypes");
const tstring NamePipeExtensionGetServiceTypeSettings = _T("PipeExtensionGetServiceTypeSettings");
const tstring NamePipeExtensionServiceCreate = _T("PipeExtensionServiceCreate");
const tstring NamePipeExtensionServiceDestroy = _T("PipeExtensionServiceDestroy");
const tstring NamePipeExtensionServiceSend = _T("PipeExtensionServiceSend");
const tstring NamePipeExtensionServiceReceive = _T("PipeExtensionServiceReceive");
const tstring NamePipeExtensionServiceGetNodeChildren = _T("PipeExtensionServiceGetNodeChildren");
const tstring NamePipeExtensionServiceGetNodeMessageTypes = _T("PipeExtensionServiceGetNodeMessageTypes");
const tstring NamePipeExtensionServiceGetNodeInfo = _T("PipeExtensionServiceGetNodeInfo");

typedef void(*FktPipeExtensionGetServiceTypes)(PipeExtensionCbContext, PipeExtensionCbStr);
typedef void(*FktPipeExtensionGetServiceTypeSettings)(PipeExtensionCbContext, PipeExtensionStr, PipeExtensionCbStr);
typedef void(*FktPipeExtensionServiceCreate)(PipeExtensionStr, PipeExtensionStr, PipeExtensionStr, PipeExtensionStr, HPipeExtensionService*);
typedef void(*FktPipeExtensionServiceDestroy)(HPipeExtensionService);
typedef void(*FktPipeExtensionServiceSend)(HPipeExtensionService, PipeExtensionStr);
typedef void(*FktPipeExtensionServiceReceive)(HPipeExtensionService, PipeExtensionCbContext, PipeExtensionCbStr);
typedef void(*FktPipeExtensionServiceGetNodeChildren)(HPipeExtensionService, PipeExtensionStr, PipeExtensionCbContext, PipeExtensionCbStr);
typedef void(*FktPipeExtensionServiceGetNodeMessageTypes)(HPipeExtensionService, PipeExtensionStr, PipeExtensionCbContext, PipeExtensionCbStr);
typedef void(*FktPipeExtensionServiceGetNodeInfo)(HPipeExtensionService, PipeExtensionStr, PipeExtensionCbContext, PipeExtensionCbStr);

//======================================================================================================================

struct PipeExtensionFunctions {
	FktPipeExtensionGetServiceTypes							fktPipeExtensionGetServiceTypes				= nullptr;
	FktPipeExtensionGetServiceTypeSettings					fktPipeExtensionGetServiceTypeSettings		= nullptr;
	FktPipeExtensionServiceCreate							fktPipeExtensionServiceCreate				= nullptr;
	FktPipeExtensionServiceDestroy							fktPipeExtensionServiceDestroy				= nullptr;
	FktPipeExtensionServiceSend								fktPipeExtensionServiceSend					= nullptr;
	FktPipeExtensionServiceReceive							fktPipeExtensionServiceReceive				= nullptr;
	FktPipeExtensionServiceGetNodeChildren					fktPipeExtensionServiceGetNodeChildren		= nullptr;
	FktPipeExtensionServiceGetNodeMessageTypes				fktPipeExtensionServiceGetNodeMessageTypes	= nullptr;
	FktPipeExtensionServiceGetNodeInfo						fktPipeExtensionServiceGetNodeInfo			= nullptr;
};

//======================================================================================================================

class PipeExtensionServiceInstance : public IPipeExtensionService {
private:
	PipeExtensionFunctions _functions;
	HPipeExtensionService _service;

public:
	PipeExtensionServiceInstance(PipeExtensionFunctions functions, HPipeExtensionService service) : _functions(functions), _service(service) {}

	virtual ~PipeExtensionServiceInstance() {
		_functions.fktPipeExtensionServiceDestroy(_service);
	}

public:
	virtual void send(const tstring& message) {
		_functions.fktPipeExtensionServiceSend(_service, message.c_str());
	}

	//------------------------------------------------------------------------------------------------------------------

	virtual tstring receive() {
		tstring messages;

		_functions.fktPipeExtensionServiceReceive(_service, &messages, [](LibPipeCbContext context, LibPipeStr messagesData) {
			(*static_cast<tstring*>(context)) = messagesData;
		});

		return messages;
	}
	
	//------------------------------------------------------------------------------------------------------------------

	virtual tstring nodeChildren(tstring address) {
		tstring children;

		_functions.fktPipeExtensionServiceGetNodeChildren(_service, address.c_str(), &children, [](PipeExtensionCbContext context, PipeExtensionStr childrenData) {
			(*static_cast<tstring*>(context)) = childrenData;
		});

		return children;
	}

	//------------------------------------------------------------------------------------------------------------------

	virtual tstring nodeMessageTypes(tstring address) {
		tstring messageTypes;

		_functions.fktPipeExtensionServiceGetNodeMessageTypes(_service, address.c_str(), &messageTypes, [](PipeExtensionCbContext context, PipeExtensionStr messageTypesData) {
			(*static_cast<tstring*>(context)) = messageTypesData;
		});

		return messageTypes;
	}

	//------------------------------------------------------------------------------------------------------------------

	virtual tstring nodeInfo(tstring address) {
		tstring info;

		_functions.fktPipeExtensionServiceGetNodeInfo(_service, address.c_str(), &info, [](PipeExtensionCbContext context, PipeExtensionStr infoData) {
			(*static_cast<tstring*>(context)) = infoData;
		});

		return info;
	}
};

//======================================================================================================================

class PipeExtensionInstance : public IPipeExtension {
private:
	PipeExtensionFunctions _functions;

public:
	PipeExtensionInstance(PipeExtensionFunctions functions) : _functions(functions) {}
	virtual ~PipeExtensionInstance() {}

public:
	virtual tstring serviceTypes() {
		tstring types;
		
		_functions.fktPipeExtensionGetServiceTypes(&types, [](PipeExtensionCbContext context, PipeExtensionStr typesData) {
			(*static_cast<tstring*>(context)) = typesData;
		});

		return types;
	}

	//------------------------------------------------------------------------------------------------------------------

	virtual tstring serviceTypeSettings(tstring serviceType) {
		tstring typeSettings;

		_functions.fktPipeExtensionGetServiceTypeSettings(&typeSettings, serviceType.c_str(), [](PipeExtensionCbContext context, PipeExtensionStr typeSettingsData) {
			(*static_cast<tstring*>(context)) = typeSettingsData;
		});

		return typeSettings;
	}

	//------------------------------------------------------------------------------------------------------------------

	virtual IPipeExtensionService* create(tstring serviceType, tstring id, tstring path, tstring settings) {
		HPipeExtensionService service = 0;

		_functions.fktPipeExtensionServiceCreate(serviceType.c_str(), id.c_str(), path.c_str(), settings.c_str(), &service);

		return new PipeExtensionServiceInstance(_functions, service);
	}

	//------------------------------------------------------------------------------------------------------------------

	virtual void destroy(IPipeExtensionService* service) {
		_functions.fktPipeExtensionServiceDestroy(reinterpret_cast<HPipeExtensionService>(service));
	}
};

//======================================================================================================================
