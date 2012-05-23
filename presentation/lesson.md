!SLIDE

# Blocks

!SLIDE

## Setup, Action, Teardown

```ruby
connection = Service.open(HOST,USER,PASS)
connection.query "for big data"
connection.close
```

!SLIDE

## Function with a Parameter

```ruby
def query(query_string)
  connection = Service.open(HOST,USER,PASS)
  connection.query query_string
  connection.close
end
```

!SLIDE

## Duplication

```ruby
def query(query_string)
  connection = Service.open(HOST,USER,PASS)
  connection.query query_string
  connection.close
end

def update(update_string)
  connection = Service.open(HOST,USER,PASS)
  connection.update update_string
  connection.close
end
```
    
!SLIDE

## You want to do something like this!

```ruby
def with_a_connection(EXECUTE_THIS_CODE)
  connection = Service.open(HOST,USER,PASS)
  EXECUTE_THIS_CODE
  connection.close
end

with_a_connection QUERY_CODE
with_a_connection UPDATE_CODE
```

!SLIDE 

## Taking a step back

```ruby
def query(connection,query_string)
  connection.query query_string
end

connection = Service.open(HOST,USER,PASS)
query(connection,"for big data")
connection.close
```

!SLIDE

## More functions

```ruby
def query(connection,query_string)
  connection.query query_string
end

def with_a_connection(operation,param)
  connection = Service.open(HOST,USER,PASS)
  send(operation,connection,param)
  connection.close
end

with_a_connection :query, "big_data"
```

!SLIDE

## Mo' Functions, Mo' Problems

```ruby
def query(connection,query_string) ; end
def query_ordered(connection,query_string,sorting) ; end 
def query_filtered(connection,query_string,filter) ; end
```

!SLIDE

## Maybe you could do this instead

```ruby
def query(connection,query_params = {}) ; end

with_a_connection :query, :query => "big_data", 
  :filter => false, :ordered => :ascending
```

!SLIDE

## I've got 99 parameters
## and I can't keep track of one

```ruby
def query(connection,query_param = {})
  
  if query_param[:filter] 
  
    if query_param[:ordered] == :ascending
      results = connection.asc_query_with_filter query_param[:query], query_param[:filter]
    elsif query_param[:ordered] == :descending
      results = connection.desc_query_with_filter query_param[:query], query_param[:filter]
    else
      results = connection.query_with_filter query_param[:query], query_param[:filter]
    end
    
  else
    if query_param[:ordered] == :ascending
      results = connection.asc_query query_param[:query]
    elsif query_param[:ordered] == :descending
      results = connection.desc_query query_param[:query]
    else
      results = connection.query_with_filter query_param[:query]
    end
  end
  
end
```
      
!SLIDE quote

## Things used to be so Simple!

!SLIDE

## Why can't I do something like this?

```ruby
with_a_connection do |connection|
  connection.query "for big data"
end

with_a_connection do |connection|
  connection.update "my data set"
end
```

!SLIDE

## Doing it cleanly

```ruby
def with_a_connection
  connection = Service.open(HOST,USER,PASS)
  
  if block_given?
    yield(connection)
  end
  
  connection.close
end

with_a_connection do |connection|
  connection.query "for big data"
end
```

!SLIDE

## This is kind of like...

```ruby
  with_a_connection do |connection|
    connection.query "for big data"
  end
```
    
    
## you created this...
    
```ruby
def anonymous_function(connection)
  connection.query "for big data"
end
```
    

!SLIDE

## That the yield will call!

```ruby
def with_a_connection
  connection = Service.open(HOST,USER,PASS)

  if block_given?
    # anonymous_function(connection)
    yield(connection)
  end

  connection.close
end
```

!SLIDE

## Succinct

```ruby
def using
  connection = Service.open(HOST,USER,PASS)
  yield connection if block_given?
  connection.close
end
```

!SLIDE

## Doing it safely

```ruby
def safe_using
  
  current_connection = Service.open(HOST,USER,PASS)
  yield current_connection if block_given?
  connection.close
  
rescue => exception
  warn "There was an error #{exception}"
end

safe_using do |con|
  con.query "for even bigger data"
end
```

!SLIDE

## Using yield?

```ruby
def safe_using(&rumpelstiltskin)
  using yield
rescue => exception
  warn "There was an error #{exception}"
end

safe_using do |con|
  con.query "for even bigger data"
end
```

!SLIDE

## Giving the block a name

```ruby
def safe_using(&block)
  using(&block) if block
rescue => exception
  warn "There was an error #{exception}"
end

safe_using do |con|
  con.query "for even bigger data"
end
```

!SLIDE

## Name it your way

```ruby
def safe_using(&rumpelstiltskin)
  using(&rumpelstiltskin) if rumpelstiltskin
rescue => exception
  warn "There was an error #{exception}"
end

safe_using do |con|
  con.query "for even bigger data"
end
```
