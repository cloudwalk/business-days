# Business Days

Methods to check if a given date is a business days and to perform computations based on Business days.

## Installation

Add to your Gemfile:

```
gem 'business-days'
```

## Example

To add 2 business days to current time:
```
BusinessDays::business_days_from_utc_time(2, Time.now.utc)
```

## Limitations

- Hard coded to work with Brazilian times.
- Can only add business days to a given date, not subtract.
