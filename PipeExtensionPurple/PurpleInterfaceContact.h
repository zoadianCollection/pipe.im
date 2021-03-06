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

#include "CommonHeader.h"
#include "PurpleInterface.h"

//======================================================================================================================

class PurpleInterfaceContact : public PipeServiceNode {
private:
	PurpleBlistNode* _contact;
	PurpleBlistNodeType _contactType;
	PurpleConversation* _conversation;

public:
	PurpleInterfaceContact(const tstring& address, const tstring& path, PipeObjectPtr settings, const tstring& instance_name, const tstring& instance_description, PurpleBlistNode* contact);
	~PurpleInterfaceContact();

public:
	bool isBuddy() { return _contactType == PURPLE_BLIST_BUDDY_NODE; }
	bool isChat() { return _contactType == PURPLE_BLIST_CHAT_NODE; }
	PurpleBlistNode* contactHandle() { return _contact; }
	PurpleBuddy* buddyHandle() { return reinterpret_cast<PurpleBuddy*>(_contact); }
	PurpleChat* chatHandle() { return reinterpret_cast<PurpleChat*>(_contact); }
	PurpleConversation* conversationHandle() { return _conversation; }
	tstring contactName() { 
		if(isBuddy()) { return safe_tstring(buddyHandle()->name); }
		else if(isChat()) { return safe_tstring(chatHandle()->alias); }
		return _T("");
	}

public:
	void onConversationChanged(PurpleConversation* conversation);
	void onTopicChanged(tstring user, tstring topic);
	void onTypingStateChanged(PurpleTypingState state);

	void onMessage(tstring sender, tstring message);

	void onChatStatusChanged(bool joined);
	void onChatBuddyOnline(tstring name, PurpleConvChatBuddyFlags flags);
	void onChatBuddyOffline(tstring name, tstring reason);

	void onStatusChanged(PurpleStatus* status);
	void onStatusTypeChanged(tstring statusType);
	void onStatusMessageChanged(tstring message);
	void onStatusPriorityChanged(int priority);
	void onStatusNickChanged(tstring nick);
	void onIconChanged();
	void onIdleChanged(bool idle);

};

//======================================================================================================================
