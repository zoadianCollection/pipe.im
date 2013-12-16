/*

Boost Software License - Version 1.0 - August 17th, 2003

Permission is hereby granted, free of charge, to any person or organization
obtaining a copy of the software and accompanying documentation covered by
this license (the "Software") to use, reproduce, display, distribute,
execute, and transmit the Software, and to prepare derivative works of the
Software, and to permit third-parties to whom the Software is furnished to
do so, all subject to the following:

The copyright notices in the Software and this entire statement, including
the above license grant, this restriction and the following disclaimer,
must be included in all copies of the Software, in whole or in part, and
all derivative works of the Software, unless such copies or derivative
works are solely in the form of machine-executable object code generated by
a source language processor.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

*/ 

module derelict.purple.cmds;

import derelict.glib.gtypes;
import derelict.glib.glibconfig;
import derelict.glib.glist;
import derelict.purple.conversation;
extern (C):

alias _PurpleCmdStatus PurpleCmdStatus;
alias _PurpleCmdRet PurpleCmdRet;
alias _PurpleCmdRet function (_PurpleConversation*, const(char)*, char**, char**, void*) PurpleCmdFunc;
alias uint PurpleCmdId;
alias _PurpleCmdPriority PurpleCmdPriority;
alias _PurpleCmdFlag PurpleCmdFlag;

enum _PurpleCmdStatus
{
	PURPLE_CMD_STATUS_OK = 0,
	PURPLE_CMD_STATUS_FAILED = 1,
	PURPLE_CMD_STATUS_NOT_FOUND = 2,
	PURPLE_CMD_STATUS_WRONG_ARGS = 3,
	PURPLE_CMD_STATUS_WRONG_PRPL = 4,
	PURPLE_CMD_STATUS_WRONG_TYPE = 5
}

enum _PurpleCmdRet
{
	PURPLE_CMD_RET_OK = 0,
	PURPLE_CMD_RET_FAILED = 1,
	PURPLE_CMD_RET_CONTINUE = 2
}

enum _PurpleCmdPriority
{
	PURPLE_CMD_P_VERY_LOW = -1000,
	PURPLE_CMD_P_LOW = 0,
	PURPLE_CMD_P_DEFAULT = 1000,
	PURPLE_CMD_P_PRPL = 2000,
	PURPLE_CMD_P_PLUGIN = 3000,
	PURPLE_CMD_P_ALIAS = 4000,
	PURPLE_CMD_P_HIGH = 5000,
	PURPLE_CMD_P_VERY_HIGH = 6000
}

enum _PurpleCmdFlag
{
	PURPLE_CMD_FLAG_IM = 1,
	PURPLE_CMD_FLAG_CHAT = 2,
	PURPLE_CMD_FLAG_PRPL_ONLY = 4,
	PURPLE_CMD_FLAG_ALLOW_WRONG_ARGS = 8
}

extern( C ) nothrow 
{
	alias da_purple_cmd_register = PurpleCmdId function(const(gchar)* cmd, const(gchar)* args, PurpleCmdPriority p, PurpleCmdFlag f, const(gchar)* prpl_id, PurpleCmdFunc func, const(gchar)* helpstr, void* data);	
    alias da_purple_cmd_unregister = void function(PurpleCmdId id);																																					
    alias da_purple_cmd_do_command = PurpleCmdStatus function(PurpleConversation* conv, const(gchar)* cmdline, const(gchar)* markup, gchar** errormsg);																
    alias da_purple_cmd_list = GList* function(PurpleConversation* conv);																																			
    alias da_purple_cmd_help = GList* function(PurpleConversation* conv, const(gchar)* cmd);																														
    alias da_purple_cmds_get_handle = gpointer function();																																							
    alias da_purple_cmds_init = void function();																																									
    alias da_purple_cmds_uninit = void function();																																									
}

__gshared
{
	da_purple_cmd_register purple_cmd_register;
	da_purple_cmd_unregister purple_cmd_unregister;
	da_purple_cmd_do_command purple_cmd_do_command;
	da_purple_cmd_list purple_cmd_list;
	da_purple_cmd_help purple_cmd_help;
	da_purple_cmds_get_handle purple_cmds_get_handle;
	da_purple_cmds_init purple_cmds_init;
	da_purple_cmds_uninit purple_cmds_uninit;
}