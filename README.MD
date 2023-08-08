# Currency Converter
Currency converter utility that computes source currency to target currency with rates from CNB.

## Instalation
```
gem build rates.gemspec
gem install rates-0.1.0.gem
```

## Usage
Using gem
```
rates <command> <args>
```

Without gem
```
ruby bin/rates <command> <args>
```

## Commands
```
rates --convert, -c --amount=N --source=SOURCE --target=TARGET  # Convert the given amount from source currency to target currency.
rates --supported, -s                                           # List supported currencies.
rates --version, -v                                             # Print the version.
rates help [COMMAND]                                            # Describe available commands or one specific command
```

## Tests
Run test
```
ruby test/rates_test.rb
```
