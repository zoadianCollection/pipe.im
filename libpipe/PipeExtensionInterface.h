//======================================================================================================================

#pragma once

//======================================================================================================================

#include "PipeExtensionAPI.h"

//======================================================================================================================

class IPipeExtension {
public:
	virtual PipeArrayPtr serviceTypes() = 0;
	
	virtual HPipeExtensionService create(const tstring& serviceType, const tstring& address, const tstring& path, PipeObjectPtr settings) = 0;
	virtual void destroy(HPipeExtensionService service) = 0;
	
	virtual void process() = 0;

	virtual void push(PipeArrayPtr messages) = 0;
	virtual PipeArrayPtr pull() = 0;
};

//======================================================================================================================
