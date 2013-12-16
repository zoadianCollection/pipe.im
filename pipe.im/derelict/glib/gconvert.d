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

module derelict.glib.gconvert;

import derelict.glib.gtypes;
import derelict.glib.glibconfig;
import derelict.glib.gquark;
import derelict.glib.gerror;
import core.stdc.config;

extern (C):

alias _Anonymous_0 GConvertError;
alias _GIConv* GIConv;

enum _Anonymous_0
{
	G_CONVERT_ERROR_NO_CONVERSION = 0,
	G_CONVERT_ERROR_ILLEGAL_SEQUENCE = 1,
	G_CONVERT_ERROR_FAILED = 2,
	G_CONVERT_ERROR_PARTIAL_INPUT = 3,
	G_CONVERT_ERROR_BAD_URI = 4,
	G_CONVERT_ERROR_NOT_ABSOLUTE_PATH = 5
}

struct _GIConv;

extern( C ) nothrow 
{
    alias da_g_convert_error_quark = GQuark function();																																												
    alias da_g_iconv_open = GIConv function(const(gchar)* to_codeset, const(gchar)* from_codeset);																																	
    alias da_g_iconv = gsize function(GIConv converter, gchar** inbuf, gsize* inbytes_left, gchar** outbuf, gsize* outbytes_left);																									
    alias da_g_iconv_close = gint function(GIConv converter);																																										
    alias da_g_convert = gchar* function(const(gchar)* str, gssize len, const(gchar)* to_codeset, const(gchar)* from_codeset, gsize* bytes_read, gsize* bytes_written, GError** error);												
    alias da_g_convert_with_iconv = gchar* function(const(gchar)* str, gssize len, GIConv converter, gsize* bytes_read, gsize* bytes_written, GError** error);																		
    alias da_g_convert_with_fallback = gchar* function(const(gchar)* str, gssize len, const(gchar)* to_codeset, const(gchar)* from_codeset, const(gchar)* fallback, gsize* bytes_read, gsize* bytes_written, GError** error);		
    alias da_g_locale_to_utf8 = gchar* function(const(gchar)* opsysstring, gssize len, gsize* bytes_read, gsize* bytes_written, GError** error);																					
    alias da_g_locale_from_utf8 = gchar* function(const(gchar)* utf8string, gssize len, gsize* bytes_read, gsize* bytes_written, GError** error);																					
    alias da_g_filename_to_utf8 = gchar* function(const(gchar)* opsysstring, gssize len, gsize* bytes_read, gsize* bytes_written, GError** error);																					
    alias da_g_filename_from_utf8 = gchar* function(const(gchar)* utf8string, gssize len, gsize* bytes_read, gsize* bytes_written, GError** error);																					
    alias da_g_filename_from_uri = gchar* function(const(gchar)* uri, gchar** hostname, GError** error);																															
    alias da_g_filename_to_uri = gchar* function(const(gchar)* filename, const(gchar)* hostname, GError** error);																													
    alias da_g_filename_display_name = gchar* function(const(gchar)* filename);																																						
    alias da_g_get_filename_charsets = gboolean function(const(gchar**)* charsets);																																					
    alias da_g_filename_display_basename = gchar* function(const(gchar)* filename);																																					
    alias da_g_uri_list_extract_uris = gchar** function(const(gchar)* uri_list);																																					
}

__gshared
{
    da_g_convert_error_quark g_convert_error_quark; 
    da_g_iconv_open g_iconv_open; 
    da_g_iconv g_iconv; 
    da_g_iconv_close g_iconv_close; 
    da_g_convert g_convert; 
    da_g_convert_with_iconv g_convert_with_iconv; 
    da_g_convert_with_fallback g_convert_with_fallback; 
    da_g_locale_to_utf8 g_locale_to_utf8; 
    da_g_locale_from_utf8 g_locale_from_utf8; 
    da_g_filename_to_utf8 g_filename_to_utf8; 
    da_g_filename_from_utf8 g_filename_from_utf8; 
    da_g_filename_from_uri g_filename_from_uri; 
    da_g_filename_to_uri g_filename_to_uri; 
    da_g_filename_display_name g_filename_display_name; 
    da_g_get_filename_charsets g_get_filename_charsets; 
    da_g_filename_display_basename g_filename_display_basename; 
    da_g_uri_list_extract_uris g_uri_list_extract_uris; 
}