require 'active_support/all'
require 'holidays'
require 'singleton'

class BusinessDaysSingleton
  include Singleton

  def initialize
    @holidays = []

    # Setup holidays in an interval of 3 years
    from = Time.current.year
    to = Time.current.year + 2

    # 1. Get all holidays in given years interval from Holidays gem
    Holidays.between(Date.civil(from, 1, 1), Date.civil(to, 12, 31), :br, :informal).each do |holiday|
      # Include holiday
      @holidays.push(holiday[:date])

      # 2. If Carnaval, include the day before and after it (they are bank holidays)
      if holiday[:name] == "Carnaval"
        @holidays.push(holiday[:date] - 1.day)
        @holidays.push(holiday[:date] + 1.day)
      end
    end

    # 3. Add the latest business day in each year (it's a bank holiday)
    (from..to).each do |year|
      @holidays.push(latest_non_bank_businness_day(year))
    end
  end

  def business_days_from_utc_time(days, time)
    # We count days based on Brasilia timezone
    date = time.in_time_zone('Brasilia').to_date

    # Add days until we reach the specified business days
    count = 0
    while count < days
      date += 1.days
      if business_day?(date)
        count +=1
      end
    end

    date
  end

  def business_day?(date)
    raise ArgumentError.new('Not a date') unless date.kind_of?(Date)

    weekend = [6, 7].include?(date.cwday)
    !(weekend || @holidays.include?(date))
  end

  def add_holiday(date)
    raise ArgumentError.new('Not a date') unless date.kind_of?(Date)

    @holidays.push(date)
  end

  private

  def latest_non_bank_businness_day(year)
    d = Date.civil(year, 12, 31)
    while !self.business_day?(d)
      d = d - 1.day
    end

    d
  end
end

# Avoid calling the instance method on every call
BusinessDays = BusinessDaysSingleton.instance
