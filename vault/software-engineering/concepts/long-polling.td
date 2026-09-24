---
_type: SoftEngConcept
_label: 'Long Polling'
journey: fref("software-engineering/index.td")
status: 'learning'
tags:
  - 'networking'
---

An HTTP technique where the server holds an open connection until it has new data to send.

## How It Works

1. Client sends an HTTP request to the server.
2. Server holds the connection open (does not respond immediately).
3. When new data is available, the server responds.
4. Client immediately sends a new request, repeating the cycle.

## Comparison

- **Polling**: Client periodically asks "anything new?" Most responses are empty. Wastes bandwidth.
- **Long polling**: Server holds the connection until there is something to say. More efficient but each client holds one open connection.
- **WebSockets**: Persistent bidirectional connection. Lower per-message overhead. More complex to implement.

## Tradeoffs

- Simpler than WebSockets but each client holds an open HTTP connection.
- At scale (e.g. 1M active connections), the server must hold many connections simultaneously. This is why message queues are often introduced to decouple notification fanout from connection management.
- Sufficient for file change notifications where sub-second latency is not required.
