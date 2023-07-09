TIngus Sniffer Class
--------------------

To compile with D3 or D4, you can select {$IFDEF} directive 
in Packet32.Pas.

Update:
 - May 10, 1999: Francois Piette (francois.piette@pophost.eunet.be)
		 fixed ProtoHdr using shift operation
		 to make it faster. :) (thanks Francois Piette)
 - May 14, 1999: Add IPLength property to TIngusIPPacket
 - May 17, 1999: FPiette added auto compiler detection
			 MacAddr always handled as PChar

(C)Jagad (don@indo.net.id)