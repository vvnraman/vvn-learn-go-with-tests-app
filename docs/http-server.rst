.. _http-server:

HTTP server
###########

Web server where users can track how many games players have won.

- ``GET /players/{name}`` should return a number indicating the total number of
  wins

- ``POST /players/{name}`` should record a win for that name, incrementing for
  every subsequent ``POST``.

net.http
********

ListenAndServe
==============

.. code-block:: go

   func ListenAndServe(addr string, handler Handler) error

https://golang.org/pkg/net/http/#ListenAndServe

``ListenAndServe`` listens on the TCP network address ``addr`` and then calls
``Serve`` with ``handler`` to handle requests on incoming connections. Accepted
connections are configured to enable TCP keep-alives (default).


.. code-block:: go

   type Handler interface {
   	ServerHTTP(ResponseWriter, *Request)
   }

The ``handler`` is typically ``nil`` in which case the ``DefaultServeMux`` is
used.

HandlerFunc
===========

.. code-block:: go

   type HandlerFunc func(ResponseWriter, *Request)

This is an adapter type which returns us a type to call a function (assuming it
has the right signature), without us needing to implement a struct which
implements ``Handler`` type.


