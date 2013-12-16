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

module derelict.purple.request;

import derelict.glib.gtypes;
import derelict.glib.glibconfig;
import derelict.glib.glist;
import derelict.glib.ghash;
import derelict.purple.account;
import derelict.purple.conversation;
import core.stdc.config;
import std.c.stdarg;

extern (C):

alias _PurpleRequestField PurpleRequestField;
alias _Anonymous_0 PurpleRequestType;
alias _Anonymous_1 PurpleRequestFieldType;
alias _Anonymous_2 PurpleRequestFields;
alias _Anonymous_3 PurpleRequestFieldGroup;
alias _Anonymous_4 PurpleRequestUiOps;
alias void function (void*, const(char)*) PurpleRequestInputCb;
alias void function (void*, int) PurpleRequestActionCb;
alias void function (void*, int) PurpleRequestChoiceCb;
alias void function (void*, _Anonymous_2*) PurpleRequestFieldsCb;
alias void function (void*, const(char)*) PurpleRequestFileCb;

enum _Anonymous_0
{
	PURPLE_REQUEST_INPUT = 0,
	PURPLE_REQUEST_CHOICE = 1,
	PURPLE_REQUEST_ACTION = 2,
	PURPLE_REQUEST_FIELDS = 3,
	PURPLE_REQUEST_FILE = 4,
	PURPLE_REQUEST_FOLDER = 5
}

enum _Anonymous_1
{
	PURPLE_REQUEST_FIELD_NONE = 0,
	PURPLE_REQUEST_FIELD_STRING = 1,
	PURPLE_REQUEST_FIELD_INTEGER = 2,
	PURPLE_REQUEST_FIELD_BOOLEAN = 3,
	PURPLE_REQUEST_FIELD_CHOICE = 4,
	PURPLE_REQUEST_FIELD_LIST = 5,
	PURPLE_REQUEST_FIELD_LABEL = 6,
	PURPLE_REQUEST_FIELD_IMAGE = 7,
	PURPLE_REQUEST_FIELD_ACCOUNT = 8
}

struct _Anonymous_2
{
	GList* groups;
	GHashTable* fields;
	GList* required_fields;
	void* ui_data;
}

struct _Anonymous_3
{
	PurpleRequestFields* fields_list;
	char* title;
	GList* fields;
}

struct _PurpleRequestField
{
	PurpleRequestFieldType type;
	PurpleRequestFieldGroup* group;
	char* id;
	char* label;
	char* type_hint;
	gboolean visible;
	gboolean required;
	union
	{
		struct
		{
			gboolean multiline;
			gboolean masked;
			gboolean editable;
			char* default_value_charp;
			char* value_charp;
		}
		struct
		{
			int default_value_int;
			int value_int;
		}
		struct
		{
			gboolean default_value_bool;
			gboolean value_bool;
		}
		struct
		{
			int default_value_int_labels;
			int value_int_labels;
			GList* labels;
		}
		struct
		{
			GList* items;
			GList* icons;
			GHashTable* item_data;
			GList* selected;
			GHashTable* selected_table;
			gboolean multiple_selection;
		}
		struct
		{
			PurpleAccount* default_account;
			PurpleAccount* account;
			gboolean show_all;
			PurpleFilterAccountFunc filter_func;
		}
		struct
		{
			uint scale_x;
			uint scale_y;
			const(char)* buffer;
			gsize size;
		}
	}
	void* ui_data;
}

struct _Anonymous_4
{
	void* function (const(char)*, const(char)*, const(char)*, const(char)*, gboolean, gboolean, gchar*, const(char)*, GCallback, const(char)*, GCallback, PurpleAccount*, const(char)*, PurpleConversation*, void*) request_input;
	void* function (const(char)*, const(char)*, const(char)*, int, const(char)*, GCallback, const(char)*, GCallback, PurpleAccount*, const(char)*, PurpleConversation*, void*, va_list) request_choice;
	void* function (const(char)*, const(char)*, const(char)*, int, PurpleAccount*, const(char)*, PurpleConversation*, void*, size_t, va_list) request_action;
	void* function (const(char)*, const(char)*, const(char)*, PurpleRequestFields*, const(char)*, GCallback, const(char)*, GCallback, PurpleAccount*, const(char)*, PurpleConversation*, void*) request_fields;
	void* function (const(char)*, const(char)*, gboolean, GCallback, GCallback, PurpleAccount*, const(char)*, PurpleConversation*, void*) request_file;
	void function (PurpleRequestType, void*) close_request;
	void* function (const(char)*, const(char)*, GCallback, GCallback, PurpleAccount*, const(char)*, PurpleConversation*, void*) request_folder;
	void* function (const(char)*, const(char)*, const(char)*, int, PurpleAccount*, const(char)*, PurpleConversation*, gconstpointer, gsize, void*, size_t, va_list) request_action_with_icon;
	void function () _purple_reserved1;
	void function () _purple_reserved2;
	void function () _purple_reserved3;
}

alias da_purple_request_fields_new = PurpleRequestFields* function();																																																						/* da_purple_request_fields_new purple_request_fields_new; */
alias da_purple_request_fields_destroy = void function(PurpleRequestFields* fields);																																																						/* da_purple_request_fields_destroy purple_request_fields_destroy; */
alias da_purple_request_fields_add_group = void function(PurpleRequestFields* fields, PurpleRequestFieldGroup* group);																																																						/* da_purple_request_fields_add_group purple_request_fields_add_group; */
alias da_purple_request_fields_get_groups = GList* function(const(PurpleRequestFields)* fields);																																																						/* da_purple_request_fields_get_groups purple_request_fields_get_groups; */
alias da_purple_request_fields_exists = gboolean function(const(PurpleRequestFields)* fields, const(char)* id);																																																						/* da_purple_request_fields_exists purple_request_fields_exists; */
alias da_purple_request_fields_get_required = GList* function(const(PurpleRequestFields)* fields);																																																						/* da_purple_request_fields_get_required purple_request_fields_get_required; */
alias da_purple_request_fields_is_field_required = gboolean function(const(PurpleRequestFields)* fields, const(char)* id);																																																						/* da_purple_request_fields_is_field_required purple_request_fields_is_field_required; */
alias da_purple_request_fields_all_required_filled = gboolean function(const(PurpleRequestFields)* fields);																																																						/* da_purple_request_fields_all_required_filled purple_request_fields_all_required_filled; */
alias da_purple_request_fields_get_field = PurpleRequestField* function(const(PurpleRequestFields)* fields, const(char)* id);																																																						/* da_purple_request_fields_get_field purple_request_fields_get_field; */
alias da_purple_request_fields_get_string = const(char)* function(const(PurpleRequestFields)* fields, const(char)* id);																																																						/* da_purple_request_fields_get_string purple_request_fields_get_string; */
alias da_purple_request_fields_get_integer = int function(const(PurpleRequestFields)* fields, const(char)* id);																																																						/* da_purple_request_fields_get_integer purple_request_fields_get_integer; */
alias da_purple_request_fields_get_bool = gboolean function(const(PurpleRequestFields)* fields, const(char)* id);																																																						/* da_purple_request_fields_get_bool purple_request_fields_get_bool; */
alias da_purple_request_fields_get_choice = int function(const(PurpleRequestFields)* fields, const(char)* id);																																																						/* da_purple_request_fields_get_choice purple_request_fields_get_choice; */
alias da_purple_request_fields_get_account = PurpleAccount* function(const(PurpleRequestFields)* fields, const(char)* id);																																																						/* da_purple_request_fields_get_account purple_request_fields_get_account; */
alias da_purple_request_field_group_new = PurpleRequestFieldGroup* function(const(char)* title);																																																						/* da_purple_request_field_group_new purple_request_field_group_new; */
alias da_purple_request_field_group_destroy = void function(PurpleRequestFieldGroup* group);																																																						/* da_purple_request_field_group_destroy purple_request_field_group_destroy; */
alias da_purple_request_field_group_add_field = void function(PurpleRequestFieldGroup* group, PurpleRequestField* field);																																																						/* da_purple_request_field_group_add_field purple_request_field_group_add_field; */
alias da_purple_request_field_group_get_title = const(char)* function(const(PurpleRequestFieldGroup)* group);																																																						/* da_purple_request_field_group_get_title purple_request_field_group_get_title; */
alias da_purple_request_field_group_get_fields = GList* function(const(PurpleRequestFieldGroup)* group);																																																						/* da_purple_request_field_group_get_fields purple_request_field_group_get_fields; */
alias da_purple_request_field_new = PurpleRequestField* function(const(char)* id, const(char)* text, PurpleRequestFieldType type);																																																						/* da_purple_request_field_new purple_request_field_new; */
alias da_purple_request_field_destroy = void function(PurpleRequestField* field);																																																						/* da_purple_request_field_destroy purple_request_field_destroy; */
alias da_purple_request_field_set_label = void function(PurpleRequestField* field, const(char)* label);																																																						/* da_purple_request_field_set_label purple_request_field_set_label; */
alias da_purple_request_field_set_visible = void function(PurpleRequestField* field, gboolean visible);																																																						/* da_purple_request_field_set_visible purple_request_field_set_visible; */
alias da_purple_request_field_set_type_hint = void function(PurpleRequestField* field, const(char)* type_hint);																																																						/* da_purple_request_field_set_type_hint purple_request_field_set_type_hint; */
alias da_purple_request_field_set_required = void function(PurpleRequestField* field, gboolean required);																																																						/* da_purple_request_field_set_required purple_request_field_set_required; */
alias da_purple_request_field_get_type = PurpleRequestFieldType function(const(PurpleRequestField)* field);																																																						/* da_purple_request_field_get_type purple_request_field_get_type; */
alias da_purple_request_field_get_group = PurpleRequestFieldGroup* function(const(PurpleRequestField)* field);																																																						/* da_purple_request_field_get_group purple_request_field_get_group; */
alias da_purple_request_field_get_id = const(char)* function(const(PurpleRequestField)* field);																																																						/* da_purple_request_field_get_id purple_request_field_get_id; */
alias da_purple_request_field_get_label = const(char)* function(const(PurpleRequestField)* field);																																																						/* da_purple_request_field_get_label purple_request_field_get_label; */
alias da_purple_request_field_is_visible = gboolean function(const(PurpleRequestField)* field);																																																						/* da_purple_request_field_is_visible purple_request_field_is_visible; */
alias da_purple_request_field_get_type_hint = const(char)* function(const(PurpleRequestField)* field);																																																						/* da_purple_request_field_get_type_hint purple_request_field_get_type_hint; */
alias da_purple_request_field_is_required = gboolean function(const(PurpleRequestField)* field);																																																						/* da_purple_request_field_is_required purple_request_field_is_required; */
alias da_purple_request_field_get_ui_data = gpointer function(const(PurpleRequestField)* field);																																																						/* da_purple_request_field_get_ui_data purple_request_field_get_ui_data; */
alias da_purple_request_field_set_ui_data = void function(PurpleRequestField* field, gpointer ui_data);																																																						/* da_purple_request_field_set_ui_data purple_request_field_set_ui_data; */
alias da_purple_request_field_string_new = PurpleRequestField* function(const(char)* id, const(char)* text, const(char)* default_value, gboolean multiline);																																																						/* da_purple_request_field_string_new purple_request_field_string_new; */
alias da_purple_request_field_string_set_default_value = void function(PurpleRequestField* field, const(char)* default_value);																																																						/* da_purple_request_field_string_set_default_value purple_request_field_string_set_default_value; */
alias da_purple_request_field_string_set_value = void function(PurpleRequestField* field, const(char)* value);																																																						/* da_purple_request_field_string_set_value purple_request_field_string_set_value; */
alias da_purple_request_field_string_set_masked = void function(PurpleRequestField* field, gboolean masked);																																																						/* da_purple_request_field_string_set_masked purple_request_field_string_set_masked; */
alias da_purple_request_field_string_set_editable = void function(PurpleRequestField* field, gboolean editable);																																																						/* da_purple_request_field_string_set_editable purple_request_field_string_set_editable; */
alias da_purple_request_field_string_get_default_value = const(char)* function(const(PurpleRequestField)* field);																																																						/* da_purple_request_field_string_get_default_value purple_request_field_string_get_default_value; */
alias da_purple_request_field_string_get_value = const(char)* function(const(PurpleRequestField)* field);																																																						/* da_purple_request_field_string_get_value purple_request_field_string_get_value; */
alias da_purple_request_field_string_is_multiline = gboolean function(const(PurpleRequestField)* field);																																																						/* da_purple_request_field_string_is_multiline purple_request_field_string_is_multiline; */
alias da_purple_request_field_string_is_masked = gboolean function(const(PurpleRequestField)* field);																																																						/* da_purple_request_field_string_is_masked purple_request_field_string_is_masked; */
alias da_purple_request_field_string_is_editable = gboolean function(const(PurpleRequestField)* field);																																																						/* da_purple_request_field_string_is_editable purple_request_field_string_is_editable; */
alias da_purple_request_field_int_new = PurpleRequestField* function(const(char)* id, const(char)* text, int default_value);																																																						/* da_purple_request_field_int_new purple_request_field_int_new; */
alias da_purple_request_field_int_set_default_value = void function(PurpleRequestField* field, int default_value);																																																						/* da_purple_request_field_int_set_default_value purple_request_field_int_set_default_value; */
alias da_purple_request_field_int_set_value = void function(PurpleRequestField* field, int value);																																																						/* da_purple_request_field_int_set_value purple_request_field_int_set_value; */
alias da_purple_request_field_int_get_default_value = int function(const(PurpleRequestField)* field);																																																						/* da_purple_request_field_int_get_default_value purple_request_field_int_get_default_value; */
alias da_purple_request_field_int_get_value = int function(const(PurpleRequestField)* field);																																																						/* da_purple_request_field_int_get_value purple_request_field_int_get_value; */
alias da_purple_request_field_bool_new = PurpleRequestField* function(const(char)* id, const(char)* text, gboolean default_value);																																																						/* da_purple_request_field_bool_new purple_request_field_bool_new; */
alias da_purple_request_field_bool_set_default_value = void function(PurpleRequestField* field, gboolean default_value);																																																						/* da_purple_request_field_bool_set_default_value purple_request_field_bool_set_default_value; */
alias da_purple_request_field_bool_set_value = void function(PurpleRequestField* field, gboolean value);																																																						/* da_purple_request_field_bool_set_value purple_request_field_bool_set_value; */
alias da_purple_request_field_bool_get_default_value = gboolean function(const(PurpleRequestField)* field);																																																						/* da_purple_request_field_bool_get_default_value purple_request_field_bool_get_default_value; */
alias da_purple_request_field_bool_get_value = gboolean function(const(PurpleRequestField)* field);																																																						/* da_purple_request_field_bool_get_value purple_request_field_bool_get_value; */
alias da_purple_request_field_choice_new = PurpleRequestField* function(const(char)* id, const(char)* text, int default_value);																																																						/* da_purple_request_field_choice_new purple_request_field_choice_new; */
alias da_purple_request_field_choice_add = void function(PurpleRequestField* field, const(char)* label);																																																						/* da_purple_request_field_choice_add purple_request_field_choice_add; */
alias da_purple_request_field_choice_set_default_value = void function(PurpleRequestField* field, int default_value);																																																						/* da_purple_request_field_choice_set_default_value purple_request_field_choice_set_default_value; */
alias da_purple_request_field_choice_set_value = void function(PurpleRequestField* field, int value);																																																						/* da_purple_request_field_choice_set_value purple_request_field_choice_set_value; */
alias da_purple_request_field_choice_get_default_value = int function(const(PurpleRequestField)* field);																																																						/* da_purple_request_field_choice_get_default_value purple_request_field_choice_get_default_value; */
alias da_purple_request_field_choice_get_value = int function(const(PurpleRequestField)* field);																																																						/* da_purple_request_field_choice_get_value purple_request_field_choice_get_value; */
alias da_purple_request_field_choice_get_labels = GList* function(const(PurpleRequestField)* field);																																																						/* da_purple_request_field_choice_get_labels purple_request_field_choice_get_labels; */
alias da_purple_request_field_list_new = PurpleRequestField* function(const(char)* id, const(char)* text);																																																						/* da_purple_request_field_list_new purple_request_field_list_new; */
alias da_purple_request_field_list_set_multi_select = void function(PurpleRequestField* field, gboolean multi_select);																																																						/* da_purple_request_field_list_set_multi_select purple_request_field_list_set_multi_select; */
alias da_purple_request_field_list_get_multi_select = gboolean function(const(PurpleRequestField)* field);																																																						/* da_purple_request_field_list_get_multi_select purple_request_field_list_get_multi_select; */
alias da_purple_request_field_list_get_data = void* function(const(PurpleRequestField)* field, const(char)* text);																																																						/* da_purple_request_field_list_get_data purple_request_field_list_get_data; */
alias da_purple_request_field_list_add = void function(PurpleRequestField* field, const(char)* item, void* data);																																																						/* da_purple_request_field_list_add purple_request_field_list_add; */
alias da_purple_request_field_list_add_icon = void function(PurpleRequestField* field, const(char)* item, const(char)* icon_path, void* data);																																																						/* da_purple_request_field_list_add_icon purple_request_field_list_add_icon; */
alias da_purple_request_field_list_add_selected = void function(PurpleRequestField* field, const(char)* item);																																																						/* da_purple_request_field_list_add_selected purple_request_field_list_add_selected; */
alias da_purple_request_field_list_clear_selected = void function(PurpleRequestField* field);																																																						/* da_purple_request_field_list_clear_selected purple_request_field_list_clear_selected; */
alias da_purple_request_field_list_set_selected = void function(PurpleRequestField* field, GList* items);																																																						/* da_purple_request_field_list_set_selected purple_request_field_list_set_selected; */
alias da_purple_request_field_list_is_selected = gboolean function(const(PurpleRequestField)* field, const(char)* item);																																																						/* da_purple_request_field_list_is_selected purple_request_field_list_is_selected; */
alias da_purple_request_field_list_get_selected = GList* function(const(PurpleRequestField)* field);																																																						/* da_purple_request_field_list_get_selected purple_request_field_list_get_selected; */
alias da_purple_request_field_list_get_items = GList* function(const(PurpleRequestField)* field);																																																						/* da_purple_request_field_list_get_items purple_request_field_list_get_items; */
alias da_purple_request_field_list_get_icons = GList* function(const(PurpleRequestField)* field);																																																						/* da_purple_request_field_list_get_icons purple_request_field_list_get_icons; */
alias da_purple_request_field_label_new = PurpleRequestField* function(const(char)* id, const(char)* text);																																																						/* da_purple_request_field_label_new purple_request_field_label_new; */
alias da_purple_request_field_image_new = PurpleRequestField* function(const(char)* id, const(char)* text, const(char)* buf, gsize size);																																																						/* da_purple_request_field_image_new purple_request_field_image_new; */
alias da_purple_request_field_image_set_scale = void function(PurpleRequestField* field, uint x, uint y);																																																						/* da_purple_request_field_image_set_scale purple_request_field_image_set_scale; */
alias da_purple_request_field_image_get_buffer = const(char)* function(PurpleRequestField* field);																																																						/* da_purple_request_field_image_get_buffer purple_request_field_image_get_buffer; */
alias da_purple_request_field_image_get_size = gsize function(PurpleRequestField* field);																																																						/* da_purple_request_field_image_get_size purple_request_field_image_get_size; */
alias da_purple_request_field_image_get_scale_x = uint function(PurpleRequestField* field);																																																						/* da_purple_request_field_image_get_scale_x purple_request_field_image_get_scale_x; */
alias da_purple_request_field_image_get_scale_y = uint function(PurpleRequestField* field);																																																						/* da_purple_request_field_image_get_scale_y purple_request_field_image_get_scale_y; */
alias da_purple_request_field_account_new = PurpleRequestField* function(const(char)* id, const(char)* text, PurpleAccount* account);																																																						/* da_purple_request_field_account_new purple_request_field_account_new; */
alias da_purple_request_field_account_set_default_value = void function(PurpleRequestField* field, PurpleAccount* default_value);																																																						/* da_purple_request_field_account_set_default_value purple_request_field_account_set_default_value; */
alias da_purple_request_field_account_set_value = void function(PurpleRequestField* field, PurpleAccount* value);																																																						/* da_purple_request_field_account_set_value purple_request_field_account_set_value; */
alias da_purple_request_field_account_set_show_all = void function(PurpleRequestField* field, gboolean show_all);																																																						/* da_purple_request_field_account_set_show_all purple_request_field_account_set_show_all; */
alias da_purple_request_field_account_set_filter = void function(PurpleRequestField* field, PurpleFilterAccountFunc filter_func);																																																						/* da_purple_request_field_account_set_filter purple_request_field_account_set_filter; */
alias da_purple_request_field_account_get_default_value = PurpleAccount* function(const(PurpleRequestField)* field);																																																						/* da_purple_request_field_account_get_default_value purple_request_field_account_get_default_value; */
alias da_purple_request_field_account_get_value = PurpleAccount* function(const(PurpleRequestField)* field);																																																						/* da_purple_request_field_account_get_value purple_request_field_account_get_value; */
alias da_purple_request_field_account_get_show_all = gboolean function(const(PurpleRequestField)* field);																																																						/* da_purple_request_field_account_get_show_all purple_request_field_account_get_show_all; */
alias da_purple_request_field_account_get_filter = PurpleFilterAccountFunc function(const(PurpleRequestField)* field);																																																						/* da_purple_request_field_account_get_filter purple_request_field_account_get_filter; */
alias da_purple_request_input = void* function(void* handle, const(char)* title, const(char)* primary, const(char)* secondary, const(char)* default_value, gboolean multiline, gboolean masked, gchar* hint, const(char)* ok_text, GCallback ok_cb, const(char)* cancel_text, GCallback cancel_cb, PurpleAccount* account, const(char)* who, PurpleConversation* conv, void* user_data);																																																						/* da_purple_request_input purple_request_input; */
alias da_purple_request_choice = void* function(void* handle, const(char)* title, const(char)* primary, const(char)* secondary, int default_value, const(char)* ok_text, GCallback ok_cb, const(char)* cancel_text, GCallback cancel_cb, PurpleAccount* account, const(char)* who, PurpleConversation* conv, void* user_data, ...);																																																						/* da_purple_request_choice purple_request_choice; */
alias da_purple_request_choice_varg = void* function(void* handle, const(char)* title, const(char)* primary, const(char)* secondary, int default_value, const(char)* ok_text, GCallback ok_cb, const(char)* cancel_text, GCallback cancel_cb, PurpleAccount* account, const(char)* who, PurpleConversation* conv, void* user_data, va_list choices);																																																						/* da_purple_request_choice_varg purple_request_choice_varg; */
alias da_purple_request_action = void* function(void* handle, const(char)* title, const(char)* primary, const(char)* secondary, int default_action, PurpleAccount* account, const(char)* who, PurpleConversation* conv, void* user_data, size_t action_count, ...);																																																						/* da_purple_request_action purple_request_action; */
alias da_purple_request_action_varg = void* function(void* handle, const(char)* title, const(char)* primary, const(char)* secondary, int default_action, PurpleAccount* account, const(char)* who, PurpleConversation* conv, void* user_data, size_t action_count, va_list actions);																																																						/* da_purple_request_action_varg purple_request_action_varg; */
alias da_purple_request_action_with_icon = void* function(void* handle, const(char)* title, const(char)* primary, const(char)* secondary, int default_action, PurpleAccount* account, const(char)* who, PurpleConversation* conv, gconstpointer icon_data, gsize icon_size, void* user_data, size_t action_count, ...);																																																						/* da_purple_request_action_with_icon purple_request_action_with_icon; */
alias da_purple_request_action_with_icon_varg = void* function(void* handle, const(char)* title, const(char)* primary, const(char)* secondary, int default_action, PurpleAccount* account, const(char)* who, PurpleConversation* conv, gconstpointer icon_data, gsize icon_size, void* user_data, size_t action_count, va_list actions);																																																						/* da_purple_request_action_with_icon_varg purple_request_action_with_icon_varg; */
alias da_purple_request_fields = void* function(void* handle, const(char)* title, const(char)* primary, const(char)* secondary, PurpleRequestFields* fields, const(char)* ok_text, GCallback ok_cb, const(char)* cancel_text, GCallback cancel_cb, PurpleAccount* account, const(char)* who, PurpleConversation* conv, void* user_data);																																																						/* da_purple_request_fields purple_request_fields; */
alias da_purple_request_close = void function(PurpleRequestType type, void* uihandle);																																																						/* da_purple_request_close purple_request_close; */
alias da_purple_request_close_with_handle = void function(void* handle);																																																						/* da_purple_request_close_with_handle purple_request_close_with_handle; */
alias da_purple_request_file = void* function(void* handle, const(char)* title, const(char)* filename, gboolean savedialog, GCallback ok_cb, GCallback cancel_cb, PurpleAccount* account, const(char)* who, PurpleConversation* conv, void* user_data);																																																						/* da_purple_request_file purple_request_file; */
alias da_purple_request_folder = void* function(void* handle, const(char)* title, const(char)* dirname, GCallback ok_cb, GCallback cancel_cb, PurpleAccount* account, const(char)* who, PurpleConversation* conv, void* user_data);																																																						/* da_purple_request_folder purple_request_folder; */
alias da_purple_request_set_ui_ops = void function(PurpleRequestUiOps* ops);																																																						/* da_purple_request_set_ui_ops purple_request_set_ui_ops; */
alias da_purple_request_get_ui_ops = PurpleRequestUiOps* function();																																																						/* da_purple_request_get_ui_ops purple_request_get_ui_ops; */


extern( C ) nothrow 
{
	
}

__gshared
{
	
}