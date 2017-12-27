require 'active_support/all'
require 'holidays'

class BusinessDays
  class << self
    # Get holidays dates until next year
    @@holidays = []
    Holidays.between(Date.civil(Time.current.year,1,1), Date.civil(Time.current.year + 1, 12, 31), :br, :br).each do |holiday|
      @@holidays.push(holiday[:date])
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
      !(weekend || @@holidays.include?(date))
    end

    def add_holiday(date)
      raise ArgumentError.new('Not a date') unless date.kind_of?(Date)

      @@holidays.push(date)
    end
  end
end
