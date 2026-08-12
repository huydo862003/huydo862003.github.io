---
_type: Concept
title: 'Visibility'
journey: fref("programming-language-theory/index.td")
status: 'learning'
---

Owner: Huy Đỗ Nguyễn An
Category: Book walkthrough, Ruby
Parent wiki page: Ruby foundations (../Ruby%20foundations%2054af0db86b8a443b8ab70622d1aa508b.md)

Most words and tokens - most identifiers - can mean different things at different places and times.

🤔 `self` is the “current” or “default” object, a role typically assigned to many objects in sequence (though only one at a time) as a program runs.

There’s always one `self`, but what object it is will vary.

🔬 The rules of scope govern the visibility of variables (and other elements, but largely variables).

It’s important to know what scope you’re in, so that you can tell what the variables refer to and not confuse them with variables from different scopes that have the same name, nor with similarly named methods.

🖖 Between them, `self` and scope are the master keys to orienting yourself in a Ruby program.

If you know what scope you’re in and know what object is self, you’ll be able to tell what’s going on, and you’ll be able to analyze errors quickly.

🪜 Ruby provides mechanisms for making distinctions among access levels of methods.

Basically, this means rules limiting the calling of methods depending on what `self` is.

✋ What about **top-level methods**?

## Understanding `self`, the current/default object

💎 The **default object** (`self`) is one of the cornerstones of Ruby programming.

1️⃣ At every point when your program is running, there’s one and only one `self`.

🦸 Being `self` has certain **privileges**.

### Default object `self` based on position

1️⃣ There’s always one (and only one) current object or `self`.

You can tell which object it is by following the small set of rules:

${fref("concepts/plt/assets/ruby-self-rules.png")}

${fref("concepts/plt/assets/ruby-self-context.png")}

### The top-level `self` object

🐙 The term **top-level** refers to program code written ***outside*** of **any class- or module definition block**.

📝 If you open a brand-new text file and type:

```ruby
x = 1
```

You’ve created a top-level local variable `x`.

If you type:

```ruby
def m
end
```

You’ve created a top-level method.

🏃 The way `self` shifts in **class, module, and method definitions** is uniform: the keyword (`class`, `module`, or `def`) marks a switch to a new `self`.

🍉 `main` is a **special term** that the **default `self` object** uses to refer to itself.

You ***can’t*** refer to it as `main`.

Ruby will interpret your use of `main` as a regular variable or method name.

If you want to grab main for any reason, you need to assign it to a variable at the top level:

```ruby
m = self
```

${fref("concepts/plt/assets/ruby-self-assignment.png")}

### `self` as the default receiver of messages

🌟 A special rule governs method calls:

If the receiver of the message is `self`, you can **omit the receiver and the dot**.

Ruby will use `self` as the **default receiver**, meaning the message you send will be sent to `self`.

${fref("concepts/plt/assets/ruby-default-receiver.png")}

${fref("concepts/plt/assets/ruby-method-dispatch.png")}

🧗‍♂️ There’s one situation where you ***can’t*** **omit the object-plus-dot** part of a method call: when the **method name** ***ends*** with **an equal sign** - a **setter** method.

```ruby
self.venue = "Town Hall"
venue = "Town Hall"
```

The reason is that Ruby always interprets the sequence `identifier = value` as an **assignment to a local variable**.

### Resolving instance variables through `self`

🙃 A simple rule governs **instance variables** and their resolution:

Every **instance variable** you’ll ever see in a Ruby program **belongs to** ***whatever object is the current object*** (`self`) at that point in the program.

- Example

    ```ruby
    class C
     def show_var
     @v = "I am an instance variable initialized to a string."
     puts @v
     end
     @v = "Instance variables can appear anywhere...."
    end
    C.new.show_var
    ```

    The code prints the following:

    ```ruby
    I am an instance variable initialized to a string.
    ```

## Determining scope

🔬 Scope refers to the reach or visibility of identifiers, specifically variables and constants.

🧾 Different types of identifiers have different scoping rules.

### Global scope and global variables

🌐 Global scope is scope that covers the entire program.

💝 Global scope is enjoyed by global variables, which are recognizable by their initial dollar-sign (`$`) character:  They’re available everywhere.

😉 In other words, global variables never go out of scope. (An exception to this is “thread-local globals”).

### Local scope

You can tell by looking at a Ruby program where the local scopes begin and end, based on a few rules:

- The top level (outside of all definition blocks) has its own local scope.
- Every class or module-definition block (`class`, `module`) has its own local scope, even nested class-/module-definition blocks.
- Every method definition (`def`) has its own local scope; more precisely, every call to a method generates a new local scope, with all local variables reset to an undefined state.

👀 Exceptions and additions to these rules exist.

${fref("concepts/plt/assets/ruby-access-rules.png")}

### The interaction between local scope and `self`

🏦 When you start **a definition block** (`method`, `class`, `module`), you start a **new local scope**, and you also create **a block of code** with a particular `self`.

👎 But local scope and `self` don’t operate entirely in parallel, not only because they’re not the same thing, but also because they’re not the same kind of thing.

👀 Change local scope without changing `self`: recursion, etc.

Change `self` without entering a new local scope: `instance_eval` and `instance_exec` methods.

### Scope and resolution of constants

🪺 Constants can be defined inside class- and method-definition blocks.

If you know the chain of nested definitions, you can access a constant from anywhere:

```ruby
module M
 class C
	 class D
		module N
			X = 1
		end
	 end
 end
end
```

🌐 Constants have a kind of global visibility or reachability: as long as you know the path to a constant through the classes and/or modules in which it’s nested, you can get to that constant.

Stripped of their nesting, however, constants definitely aren’t globals.

🔍 **Constant lookup** bears a close resemblance to **searching a file system** for a file in a particular directory.

```ruby
module M
 class C
	 class D
		module N
			X = 1
		end
	 end
	 puts D::N::X
 end
end
```

😶‍🌫️ Absolute lookup: `::<>::<>::...`.

### Class variable syntax, scope, and visibility

❓ Class variables ***aren’t*** **class scoped**.

Rather, they’re **class-hierarchy scoped**, ***except…sometimes***.

${fref("concepts/plt/assets/ruby-protected-scope.png")}

😲 What gets printed is `200`.

The `Child` class is a subclass of `Parent`, and that means `Parent` and `Child` share the same class variables - not different class variables with the same names, but the same actual variables.

👉 To create **class-scoped variables**, use **instance variables** in class objects.

## Deploying method-access rules

### Private methods

🔐 **Private** means that the method can’t be called with an **explicit receiver** including `self`.

❓ What about **private setter methods**?

🤔  When you call a setter method, you have to specify the receiver.

❕ You can’t do this

```ruby
dog_years = age * 7
```

because Ruby will think that `dog_years` is a local variable.

You have to do this:

```ruby
self.dog_years = age * 7
```

But the need for an explicit receiver makes it hard to declare the method `dog_years=` private, at least by the logic of the “no explicit receiver” requirement for calling private methods.

🙀 The way out of this conundrum is that Ruby doesn’t apply the rule to setter methods.

If you declare `dog_years=` private, you can call it with a receiver - as long as the receiver is `self`.

👉 This isn’t even possible:

```ruby
def age=(years)
 @age = years
 dog = self
 dog.dog_years = years * 7
end
```

🚫 Execution is halted by a fatal error:

```ruby
NoMethodError: private method 'dog_years=' called for
#<Dog:0x00000101b0d1a8 @age=10>
```

### Protected methods

🤙 You can call a protected method on an object `x`, as long as the default object (`self`) is an instance of the same class as `x` or of an ancestor or descendant class of `x`’s class.

😉 A protected method is thus like a private method, but with an exemption for cases where the class of `self` (`c1`) and the class of the object having the method called on it (`c2`) are the same or related by inheritance.

${fref("concepts/plt/assets/ruby-protected-inheritance.png")}

## Writing and using top-level methods

🤔 When writing method definitions in the top level, you’re coding in ***the context*** of **the top-level default object**, `main`, which is an instance of `Object` brought into being automatically for the **sole reason** that something has to be `self`, even at the top level.

### Defining a top-level method

✋ Suppose you define a method at the top level:

```ruby
def talk
	puts "Hello"
end
```

It’s not inside a class- or module-definition block, so it doesn’t appear to be an instance method of a class or module.

👉 A method that you define at the top level is stored as a **private instance method** of the `Object` class.

The previous code is equivalent to this:

```ruby
class Object
	private
	def talk
		puts "Hello"
	end
end
```

👀 Defining **private instance methods** of `Object` has some interesting implications.

1️⃣ These methods not only can but must be called in bareword style. Because they’re private, you can only call them on `self`, and only without an explicit receiver (with the usual exemption of private setter methods, which must be called with self as the receiver).

❓ Why does this still work?

```ruby
def prints *args
    puts *args
end

self.prints 1, 2
```

Maybe something has changed since Ruby 2.1.

2️⃣ Private instance methods of `Object` can be called from anywhere in your code, because `Object` lies in the **method lookup path** of *every* **class** (except `BasicObject`, but that’s too special a case to worry about).

So a top-level method is always available.

No matter what `self` is, it will be able to **recognize the message** you send it if that message resolves to a **private instance method** of `Object`.

😮 I didn’t know that these were possible:

```ruby
class Base
    private
    def hello
        puts "hello"
    end
end

class Derived < Base
    def hello
        super
    end
end

Derived.new.hello
```

```ruby
class Base
    private
    def hello
        puts "hello"
    end
end

class Derived < Base
    def greeting
        hello
    end
end

Derived.new.greeting
```

🤔 Maybe I should have understood how all these work more carefully.
