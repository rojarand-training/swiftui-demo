## [Combine subjects](https://www.avanderlee.com/combine/passthroughsubject-currentvaluesubject-explained/)

A `PassthroughSubject` is initialized without any value. A `CurrentValueSubject` wraps a single value and publishes a new element whenever the value changes. A new element is published even **if the updated value equals the current value**. Unlike the PassthroughSubject, a CurrentValueSubject always holds a value. **A new subscriber will directly receive the current value contained in the subject**.

It’s important to understand the lifecycle of a subject. Whenever a **finished event is received, the subject will no longer pass through any new values**.

<img src="preview.gif">
