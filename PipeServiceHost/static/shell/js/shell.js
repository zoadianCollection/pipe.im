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

window.currentAddress = 'pipe';
window.authenticated = false;

window.setPrompt = function (prompt) {
    window.terminal.set_prompt(prompt);
};

window.setCurrentAddress = function (address) {
    if(address !== undefined)
        window.currentAddress = address;

    window.setPrompt(window.currentAddress + '> ');
};

window.getCookie = function (name) {
    var value = "; " + document.cookie;
    var parts = value.split("; " + name + "=");
    if (parts.length == 2) return parts.pop().split(";").shift();
};

window.requestREST = function (uri, onSuccess, onError, data) {
    var req = new XMLHttpRequest();
    req.open(data === undefined ? 'get' : 'post', 'http://' + window.location.host + '/rest/' + uri);

    req.onreadystatechange = function () {
        if (req.readyState === 4) {
            if (req.status === 200) {
                if (onSuccess !== undefined)
                    onSuccess(req.responseText);
            }
            else {
                if (onError !== undefined)
                    onError(req.status);
            }
        }
    }
    req.send(data === undefined ? null : data);
};

//======================================================================================================================

window.authenticate = function () {
    window.terminal.set_mask(false);

    window.requestREST('authenticated', function (data) {
        if (data === 'true') {
            window.authenticated = true;
            window.startShell();
        }
        else {
            var account = '';

            window.terminal.echo('');
            window.terminal.echo('Please login');
            window.terminal.echo('');
            window.setPrompt('Account: ');

            window.onShellInput = function (input) {
                if (account.length === 0) {
                    account = input;
                    window.setPrompt('Password: ');
                    window.terminal.set_mask(true);
                }
                else {
                    window.setCurrentAddress();
                    var loginData = 'account=' + encodeURIComponent(account);
                    loginData += '&'
                    loginData += 'password=' + encodeURIComponent(input);

                    window.requestREST('login', function (data) {
                        window.startShell();
                    }, function (error) {
                        window.terminal.echo('Invalid login data');
                        window.authenticated = false;
                        window.authenticate();
                        return;
                    }, loginData);
                }
            };
        }
    }, function (error) {
        window.authenticated = false;
        window.authenticate();
        return;
    });
};

window.startShell = function () {
    window.terminal.set_mask(false);

    var token = window.getCookie('authToken');
    if (token == undefined || token.length == 0) {
        window.authenticated = false;
        authenticate();
        return;
    }

    var pipe = new Pipe(window.location.host);

    pipe.shellConnect(
		function (socket) {
		    window.onShellInput = function (input) {
		        if (input == 'logout') {
		            window.requestREST('logout', function (data) {
		                window.authenticated = false;
		                window.authenticate();
		            }
                    , function (error) {
                        window.terminal.echo('Logout failed');
                    });
		        }
		        else if(input.length > 0) {
	                socket.send(input);
		        }
		    };

		    socket.send(JSON.stringify({ request: 'login', admin: (window.admin === true), shell: true, authToken: token }));

		    var currentAddress = 'pipe> ';

		    var tokenLoginSuccess = '{"success":';
		    var tokenNewAddress = 'New address: ';
		    var tokenQueryOptional = 'Do you want to add ';
		    var tokenQueryDefault = 'Do you want to use the default value ';
		    var tokenQueryValue = 'Value for ';
		    var tokenChooseEnum = 'Please choose an option';
		    var tokenCommandCompleted = 'Instance completed';
		    var tokenCommandAborted = 'Aborted command'

		    socket.onmessage = function (message) {
		    	var messagesText = message.data.toString();

		        var messages = messagesText.split('\n');
		        for (var message in messages) {
		            var messageText = messages[message];
		            if (messageText.indexOf(tokenLoginSuccess) == 0) { continue; }

		        	// New address
		            if (messageText.indexOf(tokenNewAddress) == 0) {
		                var newAddress = messageText.substr(tokenNewAddress.length).trim();
		                currentAddress = newAddress + '> ';
		                window.terminal.set_prompt(currentAddress);
		            }

		                // Query optional
		            else if (messageText.trim().indexOf(tokenQueryOptional) == 0) {
		                window.terminal.set_prompt(messageText);
		            }

		                // Query default
		            else if (messageText.trim().indexOf(tokenQueryDefault) == 0) {
		                window.terminal.set_prompt(messageText);
		            }

		                // Query enum
		            else if (messageText.trim().indexOf(tokenChooseEnum) == 0) {
		                window.terminal.set_prompt(messageText);
		            }

		                // Query value
		            else if (messageText.trim().indexOf(tokenQueryValue) == 0) {
		                window.terminal.set_prompt(messageText);
		            }

		                // Command completed
		            else if (messageText.trim().indexOf(tokenCommandCompleted) == 0) {
		                window.terminal.set_prompt(currentAddress);
		                window.terminal.echo('');
		            }

		                // Command aborted
		            else if (messageText.trim().indexOf(tokenCommandAborted) == 0) {
		                window.terminal.set_prompt(currentAddress);
		                window.terminal.echo('');
		            }


		                // Output message
		            else {
		                window.terminal.echo(messageText);
		            }
		        }
		    }

		},
		function (error) {
		    window.terminal.error(new String(error));
		    window.authenticated = false;
		    window.authenticate();
		},
		function (code, reason, wasClean) {
			window.authenticated = false;
			window.authenticate();
		}
	);
};

//======================================================================================================================

$().ready(function () {
    window.terminal = $('body').terminal(function (input, term) {
        try {
            if (window.onShellInput != undefined && window.onShellInput != null)
                window.onShellInput(input);
        } catch (e) {
            term.error(new String(e));
        }
    }, {
        greetings: '',
        name: 'pipe_shell',
        prompt: window.currentAddress + '> ',
        onBlur: function () {
            return false;
        }
    });

    window.authenticate();
});

//======================================================================================================================
