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

module derelict.glib.glist;

import derelict.glib.gtypes;
import derelict.glib.glibconfig;

extern (C):

alias _GList GList;

struct _GList
{
	gpointer data;
	GList* next;
	GList* prev;
}

alias da_g_list_alloc = GList* function();																																																						/* da_g_list_alloc g_list_alloc; */
alias da_g_list_free = void function(GList* list);																																																						/* da_g_list_free g_list_free; */
alias da_g_list_free_1 = void function(GList* list);																																																						/* da_g_list_free_1 g_list_free_1; */
alias da_g_list_free_full = void function(GList* list, GDestroyNotify free_func);																																																						/* da_g_list_free_full g_list_free_full; */
alias da_g_list_append = GList* function(GList* list, gpointer data);																																																						/* da_g_list_append g_list_append; */
alias da_g_list_prepend = GList* function(GList* list, gpointer data);																																																						/* da_g_list_prepend g_list_prepend; */
alias da_g_list_insert = GList* function(GList* list, gpointer data, gint position);																																																						/* da_g_list_insert g_list_insert; */
alias da_g_list_insert_sorted = GList* function(GList* list, gpointer data, GCompareFunc func);																																																						/* da_g_list_insert_sorted g_list_insert_sorted; */
alias da_g_list_insert_sorted_with_data = GList* function(GList* list, gpointer data, GCompareDataFunc func, gpointer user_data);																																																						/* da_g_list_insert_sorted_with_data g_list_insert_sorted_with_data; */
alias da_g_list_insert_before = GList* function(GList* list, GList* sibling, gpointer data);																																																						/* da_g_list_insert_before g_list_insert_before; */
alias da_g_list_concat = GList* function(GList* list1, GList* list2);																																																						/* da_g_list_concat g_list_concat; */
alias da_g_list_remove = GList* function(GList* list, gconstpointer data);																																																						/* da_g_list_remove g_list_remove; */
alias da_g_list_remove_all = GList* function(GList* list, gconstpointer data);																																																						/* da_g_list_remove_all g_list_remove_all; */
alias da_g_list_remove_link = GList* function(GList* list, GList* llink);																																																						/* da_g_list_remove_link g_list_remove_link; */
alias da_g_list_delete_link = GList* function(GList* list, GList* link_);																																																						/* da_g_list_delete_link g_list_delete_link; */
alias da_g_list_reverse = GList* function(GList* list);																																																						/* da_g_list_reverse g_list_reverse; */
alias da_g_list_copy = GList* function(GList* list);																																																						/* da_g_list_copy g_list_copy; */
alias da_g_list_nth = GList* function(GList* list, guint n);																																																						/* da_g_list_nth g_list_nth; */
alias da_g_list_nth_prev = GList* function(GList* list, guint n);																																																						/* da_g_list_nth_prev g_list_nth_prev; */
alias da_g_list_find = GList* function(GList* list, gconstpointer data);																																																						/* da_g_list_find g_list_find; */
alias da_g_list_find_custom = GList* function(GList* list, gconstpointer data, GCompareFunc func);																																																						/* da_g_list_find_custom g_list_find_custom; */
alias da_g_list_position = gint function(GList* list, GList* llink);																																																						/* da_g_list_position g_list_position; */
alias da_g_list_index = gint function(GList* list, gconstpointer data);																																																						/* da_g_list_index g_list_index; */
alias da_g_list_last = GList* function(GList* list);																																																						/* da_g_list_last g_list_last; */
alias da_g_list_first = GList* function(GList* list);																																																						/* da_g_list_first g_list_first; */
alias da_g_list_length = guint function(GList* list);																																																						/* da_g_list_length g_list_length; */
alias da_g_list_foreach = void function(GList* list, GFunc func, gpointer user_data);																																																						/* da_g_list_foreach g_list_foreach; */
alias da_g_list_sort = GList* function(GList* list, GCompareFunc compare_func);																																																						/* da_g_list_sort g_list_sort; */
alias da_g_list_sort_with_data = GList* function(GList* list, GCompareDataFunc compare_func, gpointer user_data);																																																						/* da_g_list_sort_with_data g_list_sort_with_data; */
alias da_g_list_nth_data = gpointer function(GList* list, guint n);																																																						/* da_g_list_nth_data g_list_nth_data; */


extern( C ) nothrow 
{
	
}

__gshared
{
	
}