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

module derelict.glib.gvarianttype;

import derelict.glib.gtypes;
import derelict.glib.glibconfig;
import core.stdc.config;

extern (C):

alias _GVariantType GVariantType;

struct _GVariantType;


alias da_g_variant_type_string_is_valid = gboolean function(const(gchar)* type_string);																																																						/* da_g_variant_type_string_is_valid g_variant_type_string_is_valid; */
alias da_g_variant_type_string_scan = gboolean function(const(gchar)* string, const(gchar)* limit, const(gchar*)* endptr);																																																						/* da_g_variant_type_string_scan g_variant_type_string_scan; */
alias da_g_variant_type_free = void function(GVariantType* type);																																																						/* da_g_variant_type_free g_variant_type_free; */
alias da_g_variant_type_copy = GVariantType* function(const(GVariantType)* type);																																																						/* da_g_variant_type_copy g_variant_type_copy; */
alias da_g_variant_type_new = GVariantType* function(const(gchar)* type_string);																																																						/* da_g_variant_type_new g_variant_type_new; */
alias da_g_variant_type_get_string_length = gsize function(const(GVariantType)* type);																																																						/* da_g_variant_type_get_string_length g_variant_type_get_string_length; */
alias da_g_variant_type_peek_string = const(gchar)* function(const(GVariantType)* type);																																																						/* da_g_variant_type_peek_string g_variant_type_peek_string; */
alias da_g_variant_type_dup_string = gchar* function(const(GVariantType)* type);																																																						/* da_g_variant_type_dup_string g_variant_type_dup_string; */
alias da_g_variant_type_is_definite = gboolean function(const(GVariantType)* type);																																																						/* da_g_variant_type_is_definite g_variant_type_is_definite; */
alias da_g_variant_type_is_container = gboolean function(const(GVariantType)* type);																																																						/* da_g_variant_type_is_container g_variant_type_is_container; */
alias da_g_variant_type_is_basic = gboolean function(const(GVariantType)* type);																																																						/* da_g_variant_type_is_basic g_variant_type_is_basic; */
alias da_g_variant_type_is_maybe = gboolean function(const(GVariantType)* type);																																																						/* da_g_variant_type_is_maybe g_variant_type_is_maybe; */
alias da_g_variant_type_is_array = gboolean function(const(GVariantType)* type);																																																						/* da_g_variant_type_is_array g_variant_type_is_array; */
alias da_g_variant_type_is_tuple = gboolean function(const(GVariantType)* type);																																																						/* da_g_variant_type_is_tuple g_variant_type_is_tuple; */
alias da_g_variant_type_is_dict_entry = gboolean function(const(GVariantType)* type);																																																						/* da_g_variant_type_is_dict_entry g_variant_type_is_dict_entry; */
alias da_g_variant_type_is_variant = gboolean function(const(GVariantType)* type);																																																						/* da_g_variant_type_is_variant g_variant_type_is_variant; */
alias da_g_variant_type_hash = guint function(gconstpointer type);																																																						/* da_g_variant_type_hash g_variant_type_hash; */
alias da_g_variant_type_equal = gboolean function(gconstpointer type1, gconstpointer type2);																																																						/* da_g_variant_type_equal g_variant_type_equal; */
alias da_g_variant_type_is_subtype_of = gboolean function(const(GVariantType)* type, const(GVariantType)* supertype);																																																						/* da_g_variant_type_is_subtype_of g_variant_type_is_subtype_of; */
alias da_g_variant_type_element = const(GVariantType)* function(const(GVariantType)* type);																																																						/* da_g_variant_type_element g_variant_type_element; */
alias da_g_variant_type_first = const(GVariantType)* function(const(GVariantType)* type);																																																						/* da_g_variant_type_first g_variant_type_first; */
alias da_g_variant_type_next = const(GVariantType)* function(const(GVariantType)* type);																																																						/* da_g_variant_type_next g_variant_type_next; */
alias da_g_variant_type_n_items = gsize function(const(GVariantType)* type);																																																						/* da_g_variant_type_n_items g_variant_type_n_items; */
alias da_g_variant_type_key = const(GVariantType)* function(const(GVariantType)* type);																																																						/* da_g_variant_type_key g_variant_type_key; */
alias da_g_variant_type_value = const(GVariantType)* function(const(GVariantType)* type);																																																						/* da_g_variant_type_value g_variant_type_value; */
alias da_g_variant_type_new_array = GVariantType* function(const(GVariantType)* element);																																																						/* da_g_variant_type_new_array g_variant_type_new_array; */
alias da_g_variant_type_new_maybe = GVariantType* function(const(GVariantType)* element);																																																						/* da_g_variant_type_new_maybe g_variant_type_new_maybe; */
alias da_g_variant_type_new_tuple = GVariantType* function(const(GVariantType*)* items, gint length);																																																						/* da_g_variant_type_new_tuple g_variant_type_new_tuple; */
alias da_g_variant_type_new_dict_entry = GVariantType* function(const(GVariantType)* key, const(GVariantType)* value);																																																						/* da_g_variant_type_new_dict_entry g_variant_type_new_dict_entry; */
alias da_g_variant_type_checked_ = const(GVariantType)* function(const(gchar)*);																																																						/* da_g_variant_type_checked_ g_variant_type_checked_; */


extern( C ) nothrow 
{
	
}

__gshared
{
	
}