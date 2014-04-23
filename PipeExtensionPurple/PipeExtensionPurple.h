//======================================================================================================================

#pragma once

//======================================================================================================================

#include "CommonHeader.h"

//======================================================================================================================

class PipeExtensionPurple : public IPipeExtension {
public:
	static PipeExtensionPurple ExtensionInstance;

private:
	std::map<tstring, IPipeExtensionService*> _services;
	bool _libpurple_init_done;

public:
	PipeExtensionPurple();
	virtual ~PipeExtensionPurple();

public:
	virtual PipeJSON::array serviceTypes();
	virtual PipeJSON::object serviceTypeSettings(tstring serviceType);
	virtual IPipeExtensionService* create(tstring serviceType, tstring address, tstring path, PipeJSON::object settings);
	virtual void destroy(IPipeExtensionService* service);
};

//======================================================================================================================
