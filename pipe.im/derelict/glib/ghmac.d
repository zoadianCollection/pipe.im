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

module derelict.glib.ghmac;

import derelict.glib.gtypes;
import derelict.glib.glibconfig;
import derelict.glib.gchecksum;
import core.stdc.config;

extern (C):

alias _GHmac GHmac;

struct _GHmac;

extern( C ) nothrow 
{
    alias da_g_hmac_new = GHmac* function(GChecksumType digest_type, const(guchar)* key, gsize key_len);													
    alias da_g_hmac_copy = GHmac* function(const(GHmac)* hmac);																								
    alias da_g_hmac_ref = GHmac* function(GHmac* hmac);																										
    alias da_g_hmac_unref = void function(GHmac* hmac);																										
    alias da_g_hmac_update = void function(GHmac* hmac, const(guchar)* data, gssize length);																
    alias da_g_hmac_get_string = const(gchar)* function(GHmac* hmac);																						
    alias da_g_hmac_get_digest = void function(GHmac* hmac, guint8* buffer, gsize* digest_len);																
    alias da_g_compute_hmac_for_data = gchar* function(GChecksumType digest_type, const(guchar)* key, gsize key_len, const(guchar)* data, gsize length);	
    alias da_g_compute_hmac_for_string = gchar* function(GChecksumType digest_type, const(guchar)* key, gsize key_len, const(gchar)* str, gssize length);	
}

__gshared
{
    da_g_hmac_new g_hmac_new; 
    da_g_hmac_copy g_hmac_copy; 
    da_g_hmac_ref g_hmac_ref; 
    da_g_hmac_unref g_hmac_unref; 
    da_g_hmac_update g_hmac_update; 
    da_g_hmac_get_string g_hmac_get_string; 
    da_g_hmac_get_digest g_hmac_get_digest; 
    da_g_compute_hmac_for_data g_compute_hmac_for_data; 
    da_g_compute_hmac_for_string g_compute_hmac_for_string; 
}