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

module derelict.glib.gmessages;

import derelict.glib.gtypes;
import derelict.glib.glibconfig;
import core.stdc.config;
import std.c.stdarg;

extern (C):

alias _Anonymous_0 GLogLevelFlags;
alias void function (const(char)*, _Anonymous_0, const(char)*, void*) GLogFunc;
alias void function (const(char)*) GPrintFunc;

enum _Anonymous_0
{
	G_LOG_FLAG_RECURSION = 1,
	G_LOG_FLAG_FATAL = 2,
	G_LOG_LEVEL_ERROR = 4,
	G_LOG_LEVEL_CRITICAL = 8,
	G_LOG_LEVEL_WARNING = 16,
	G_LOG_LEVEL_MESSAGE = 32,
	G_LOG_LEVEL_INFO = 64,
	G_LOG_LEVEL_DEBUG = 128,
	G_LOG_LEVEL_MASK = -4
}

alias da_g_printf_string_upper_bound = gsize function(const(gchar)* format, va_list args);																																																						/* da_g_printf_string_upper_bound g_printf_string_upper_bound; */
alias da_g_log_set_handler = guint function(const(gchar)* log_domain, GLogLevelFlags log_levels, GLogFunc log_func, gpointer user_data);																																																						/* da_g_log_set_handler g_log_set_handler; */
alias da_g_log_remove_handler = void function(const(gchar)* log_domain, guint handler_id);																																																						/* da_g_log_remove_handler g_log_remove_handler; */
alias da_g_log_default_handler = void function(const(gchar)* log_domain, GLogLevelFlags log_level, const(gchar)* message, gpointer unused_data);																																																						/* da_g_log_default_handler g_log_default_handler; */
alias da_g_log_set_default_handler = GLogFunc function(GLogFunc log_func, gpointer user_data);																																																						/* da_g_log_set_default_handler g_log_set_default_handler; */
alias da_g_log = void function(const(gchar)* log_domain, GLogLevelFlags log_level, const(gchar)* format, ...);																																																						/* da_g_log g_log; */
alias da_g_logv = void function(const(gchar)* log_domain, GLogLevelFlags log_level, const(gchar)* format, va_list args);																																																						/* da_g_logv g_logv; */
alias da_g_log_set_fatal_mask = GLogLevelFlags function(const(gchar)* log_domain, GLogLevelFlags fatal_mask);																																																						/* da_g_log_set_fatal_mask g_log_set_fatal_mask; */
alias da_g_log_set_always_fatal = GLogLevelFlags function(GLogLevelFlags fatal_mask);																																																						/* da_g_log_set_always_fatal g_log_set_always_fatal; */
alias da__g_log_fallback_handler = void function(const(gchar)* log_domain, GLogLevelFlags log_level, const(gchar)* message, gpointer unused_data);																																																						/* da__g_log_fallback_handler _g_log_fallback_handler; */
alias da_g_return_if_fail_warning = void function(const(char)* log_domain, const(char)* pretty_function, const(char)* expression);																																																						/* da_g_return_if_fail_warning g_return_if_fail_warning; */
alias da_g_warn_message = void function(const(char)* domain, const(char)* file, int line, const(char)* func, const(char)* warnexpr);																																																						/* da_g_warn_message g_warn_message; */
alias da_g_assert_warning = void function(const(char)* log_domain, const(char)* file, const int line, const(char)* pretty_function, const(char)* expression);																																																						/* da_g_assert_warning g_assert_warning; */
alias da_g_print = void function(const(gchar)* format, ...);																																																						/* da_g_print g_print; */
alias da_g_set_print_handler = GPrintFunc function(GPrintFunc func);																																																						/* da_g_set_print_handler g_set_print_handler; */
alias da_g_printerr = void function(const(gchar)* format, ...);																																																						/* da_g_printerr g_printerr; */
alias da_g_set_printerr_handler = GPrintFunc function(GPrintFunc func);																																																						/* da_g_set_printerr_handler g_set_printerr_handler; */


extern( C ) nothrow 
{
	
}

__gshared
{
	
}