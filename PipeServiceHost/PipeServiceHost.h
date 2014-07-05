//======================================================================================================================

#pragma once

//======================================================================================================================

#include "CommonHeader.h"

#include <Poco/Util/ServerApplication.h>
#include <Poco/Util/OptionSet.h>

//======================================================================================================================

class PipeServiceHostApplication : public Poco::Util::ServerApplication {
public:
	bool _help;
	bool _debug;

	tstring _appPath;
	tstring _extdir;
	tstring _datadir;
	tstring _staticdir;
	int _port = 9980;
	tstring _address;
	tstring _uripath;
	tstring _authToken;


public:
	PipeServiceHostApplication();
	~PipeServiceHostApplication();

public:
	int main(const std::vector<tstring>& args);

	void defineOptions(Poco::Util::OptionSet& options);
	void readOptions();

	void displayHelp(const tstring& name, const tstring& value);
};

//======================================================================================================================
