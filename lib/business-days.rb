require 'active_support/all'
require 'holidays'
require 'singleton'

class BusinessDaysSingleton
  include Singleton

  def initialize
    @holidays = []

    # Setup holidays in an interval of 3 years
    from = Time.current.year - 1
    to = Time.current.year + 2

    # 1. Get all holidays in given years interval from Holidays gem
    Holidays.between(Date.civil(from, 1, 1), Date.civil(to, 12, 31), :br, :informal).each do |holiday|
      # Include holiday
      @holidays.push(holiday[:date])

      # 2. If Carnaval, include the day before it (it's a bank holiday)
      if holiday[:name] == "Carnaval"
        @holidays.push(holiday[:date] - 1.day)
      end
    end

    # 3. Add the latest business day in each year (it's a bank holiday)
    (from..to).each do |year|
      @holidays.push(latest_non_bank_businness_day(year))
    end
  end

  # Compute the date obtained by adding the given amount of business days to the given time.
  #
  # @param days [Integer] how many business days to add to given time.
  # @param time [Time] the start time from which the business days will be added.
  # @return [Date] the computed business day
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

  # Check if the given date is a business day
  #
  # @param date [Date] the non-business date to be add.
  # @return [Boolean] true if the given date is a business day, false otherwise.
  def business_day?(date)
    raise ArgumentError.new('Not a date') unless date.kind_of?(Date)

    weekend = [6, 7].include?(date.cwday)
    !(weekend || @holidays.include?(date))
  end

  # Consider the given date as a non-business day for all commands after this.
  #
  # @param date [Date] the non-business date to be add.
  def add_holiday(date)
    raise ArgumentError.new('Not a date') unless date.kind_of?(Date)

    @holidays.push(date)
  end

  # Returns the first business day after the given date.
  #
  # @param date [Date] the reference date.
  # @return [Date] the first business day after the reference date.
  def next(date)
    raise ArgumentError.new('Not a date') unless date.kind_of?(Date)

    date = date + 1.days
    while !business_day?(date)
      date = date + 1.days
    end

    date
  end

  # Returns the first business day before the given date.
  #
  # @param date [Date] the reference date.
  # @return [Date] the first business day before the reference date.
  def previous(date)
    raise ArgumentError.new('Not a date') unless date.kind_of?(Date)

    date = date - 1.days
    while !business_day?(date)
      date = date - 1.days
    end

    date
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

class BusinessDaysInstance
  def initialize(holidays)
    @holidays = []

    holidays.each do |holiday|
      # Include holiday
      @holidays.push(Date.parse(holiday))
    end
  end

  # Check if the given date is a business day
  #
  # @param date [Date] the non-business date to be add.
  # @return [Boolean] true if the given date is a business day, false otherwise.
  def business_day?(date)
    raise ArgumentError.new('Not a date') unless date.kind_of?(Date)

    weekend = [6, 7].include?(date.cwday)
    !(weekend || @holidays.include?(date))
  end

  # Count business days between two dates.
  #
  # @param from [Date] the starting date (inclusive)
  # @param to [Date] the ending date (inclusive)

  # @return [Integer] number of business days between the two dates
  def business_days(from, to)
    raise ArgumentError.new('Not a date: from') unless from.kind_of?(Date)
    raise ArgumentError.new('Not a date: to') unless to.kind_of?(Date)
    count = 0

    while  from <= to
      count +=1 if self.business_day?(from)
      from = from + 1.day
    end

    count
  end
end

# Avoid calling the instance method on every call
BusinessDays = BusinessDaysSingleton.instance
