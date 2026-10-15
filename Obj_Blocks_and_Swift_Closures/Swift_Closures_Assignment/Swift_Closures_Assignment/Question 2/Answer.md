#1. Error when storing the performSync closure

When I tried to store the non-escaping closure parameter in a property:

storedClosure = closure

I got the compiler error:
Assigning non-escaping parameter 'closure' to an @escaping closure

This happens because closure parameters are non-escaping by default, but storing the closure in a property means it may be 
used after the function returns.

#2. Error when omitting @escaping

When I removed @escaping from performAsync:

func performAsync(completion: () -> Void)

I got the compiler error:
Escaping closure captures non-escaping parameter 'completion'

This happens because DispatchQueue.global().async executes the closure asynchronously, so the completion can run after 
performAsync returns.

#3. why the escaping case needs explicit self / [weak self] handling and the non-escaping case doesn't.

An escaping closure can outlive the function and may retain self, so it requires explicit self or [weak self] handling to 
avoid retain cycles, whereas a non-escaping closure executes before the function returns and does not have the same 
long-lived retention risk.
