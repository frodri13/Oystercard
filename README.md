# Oystercard

This project consist on simulating the process in which an Oystercard user would go through when using public transportation.

Everything from topping up the card, to using it at different stations. It takes into account the balance of the card for each trip, and whether the card is currently being used or not.

## Testing

Within the command line, inside the directory, type rspec to run the tests.

## User Stories

```
In order to use public transport
As a customer
I want money on my card
```

Before we can add any money into our Oystercard instance, we need a place to store it. So I created an instance variable called @balance = 0 in order to accomplish that. I also set it up as an attr_reader to be able to check the balance at any moment.

My initial tests checks that an instance of our class is equal to zero.

```
In order to keep using public transport
As a customer
I want to add money to my card
```

For this second functionality, I created a top_up method with a value set to a constant called DEFAULT. My test evaluates if the balance of the card is equal to the DEFAULT value after topping it up.

This method can either take an specific argument, or be used with the constant aforementioned.

```
In order to protect my money
As a customer
I don't want to put too much money on my card
```

Later on, I set a constant of LIMIT equal to 90 to fulfill this requirment. However, I decided to created a new predicate method called #balance_ok? that would return false if the balance ever gets over the LIMIT constant. I added a fail error within #top_up to guard againts this.

```
In order to pay for my journey
As a customer
I need my fare deducted from my card
```

In contrast to our #top_up method, we also have a #deduct one that would substract the MINIMUM value when taking a trip. This value was set to 1.

```
In order to get through the barriers
As a customer
I need to touch in and out
```

Two methods were created for this functionality. They simply change the status of @in_use to false or true.

```
In order to pay for my journey
As a customer
I need to have the minimum amount for a single journey
```

As mentioned before a Constant of 1 called MINIMUM was created for this.

```
In order to pay for my journey
As a customer
I need to pay for my journey when it's complete
```

Further than changing the status of @in_use, #touch_out will also use our previously mentioned #deduct method to substract the MINIMUM fare from the card. This method was set as private.

```
In order to pay for my journey
As a customer
I need to know where I've travelled from
```

#touch_in was modified to accept an argument of a station. This station's name has been set as a double in our spec. I set it up to have an attr_reader of :name.

I had to change previous tests to include the argument of staion for this method. And I changed the @in_journey to @entry_station for all tests and methods. Moreover, I changed the logic of #in_journey? to return true whenever @entry_station is not equal to nil.

My touch out method changes this value to nil.

```
In order to know where I have been
As a customer
I want to see to all my previous trips
```

```
In order to know how far I have travelled
As a customer
I want to know what zone a station is in
```

```
In order to be charged correctly
As a customer
I need a penalty charge deducted if I fail to touch in or out
```

```
In order to be charged the correct amount
As a customer
I need to have the correct fare calculated
```
