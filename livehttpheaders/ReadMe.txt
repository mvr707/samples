
LiveHTTPheaders is a cool Firefox addin that lets us see the webtraffic at protocol (GET and POST) level.
This addin displays relative URLs. For some web automation tasks, it is nice to get full/absolute URLs.
The addin can be modified to accomplish this.

(I tried to get this enhancement done by posting thde developers thread, but no avail. So here goes the self-service)

[HowToModifyAddIn]

  %  cvs -d :pserver:guest@mozdev.org:/cvs login   (Password is "guest")
  %  cvs -d :pserver:guest@mozdev.org:/cvs co livehttpheaders
  %  cd livehttpheaders/src/content
  %  EDIT Generator.js
  %  cvs diff Generator.js
Index: Generator.js
===================================================================
RCS file: /cvs/livehttpheaders/src/content/Generator.js,v
retrieving revision 1.4
diff -r1.4 Generator.js
75c75
<       var out = method + " " + url;
---
>       var out = method + " " + name;
% cd ..
% EDIT install.js
% cvs diff install.js
Index: install.js
===================================================================
RCS file: /cvs/livehttpheaders/src/install.js,v
retrieving revision 1.26
diff -r1.26 install.js
4c4
< const X_VER  =     "0.17";
---
> const X_VER  =     "0.17.mvr";

% make
% INSTALL ../downloads/livehttpheaders.xpi

Since FF requires a signed version of addin, you may bypass via
about:config
xpinstall.signatures.required to false

[/HowToModifyAddIn]


