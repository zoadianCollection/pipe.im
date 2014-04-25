//======================================================================================================================

#include "CommonHeader.h"
#include "ServiceRoot.h"
using namespace std;

//======================================================================================================================

ServiceRoot::ServiceRoot(const tstring& address, const tstring& path, const PipeJSON::object& settings) : PipeServiceNodeBase(_T("pipe"), _T("Pipe root node"), address, path, settings) {
	addCommand(
		_T("root_test"), 
		_T("A test command"),
		PipeJSON::object {
		}, 
		[&](const PipeJSON::object& message) {
			//pushOutgoing(message[msgKeyRef].string_value(), _T("root_test"), PipeJSON::object {
			//	{ _T("response"), _T("ROOT") }
			//});
		}
	);

	auto&& childNode = make_shared<PipeServiceNodeBase>(_T("subtesttype"), _T("A sub test child"), _address + addressSeparator + _T("subtest"), path, settings);

	childNode->addCommand(
		_T("child_test"),
		_T("A test command"),
		PipeJSON::object {
		},
		[&] (const PipeJSON::object& message) {
			//pushOutgoing(message[msgKeyRef].string_value(), _T("child_test"), PipeJSON::object {
			//	{ _T("response"), _T("CHILD") }
			//});
		}
	);

	addChild(childNode);

	enablePreSendHook([&](const PipeJSON::array& messages)-> PipeJSON::array {
		// TODO!!! Make json types const where applicable, make the hooks return the new array

		// TODO: Process scripts
		return messages;
	});

	enablePostReceiveHook([&](const PipeJSON::array& messages)->PipeJSON::array {
		// TODO: Process scripts
		return messages;
	});

	// TODO: Add real nodes (scripting, services etc) and remove tests
}

//----------------------------------------------------------------------------------------------------------------------

ServiceRoot::~ServiceRoot() {

}

//======================================================================================================================
