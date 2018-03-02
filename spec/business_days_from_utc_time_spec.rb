require_relative '../lib/business-days'

describe 'test' do
  it '2018-01-02 plus 1 business days should be 2018-02-03' do
    # Reference data is in DST (-02:00)
    reference = Time.parse('2018-01-02T02:50:00Z')

    # This date, in Brasilia time, will be 2018-03-02 (-02:00)
    time = Time.parse('2018-01-02T02:50:00Z')

    expect(BusinessDays.business_days_from_utc_time(1, time, reference)).to eql(Date.parse("2018-01-03"))
  end

  it '2018-03-01 plus 1 business days should be 2018-02-02' do
    # Reference data is not in DST (-03:00)
    reference = Time.parse('2018-03-02T02:50:00Z')

    # This date, in Brasilia time, will be 2018-03-01 (-03:00)
    time = Time.parse('2018-03-02T02:50:00Z')

    expect(BusinessDays.business_days_from_utc_time(1, time, reference)).to eql(Date.parse("2018-03-02"))
  end

  it '2018-01-04 plus 5 business days should be 2018-01-11' do
    # Reference data is in DST (-02:00)
    reference = Time.parse('2018-01-04T15:00:00Z')

    # This date, in Brasilia time, will be 2018-01-04 (-02:00)
    time = Time.parse('2018-01-04T15:00:00Z')

    expect(BusinessDays.business_days_from_utc_time(5, time, reference)).to eql(Date.parse("2018-01-11"))
  end

  it '2018-04-30 plus 2 business days should be 2018-05-03' do
    # Reference data is not in DST (-03:00)
    reference = Time.parse('2018-04-30T15:00:00Z')

    # This date, in Brasilia time, will be 2018-04-30 (-03:00)
    time = Time.parse('2018-04-30T15:00:00Z')

    expect(BusinessDays.business_days_from_utc_time(2, time, reference)).to eql(Date.parse("2018-05-03"))
  end

  it '2018-04-26 plus 10 business days should be 2018-05-11' do
    # Reference data will not be in DST (-03:00). Will be set from given time.

    # This date, in Brasilia time, will be 2018-04-26 (-03:00)
    time = Time.parse('2018-04-26T15:00:00Z')

    expect(BusinessDays.business_days_from_utc_time(10, time)).to eql(Date.parse("2018-05-11"))
  end

  it '2018-04-26 plus 10 business days should be 2018-05-11' do
    # Reference data is in DST (-02:00)
    reference = Time.parse('2018-01-01T15:00:00Z')

    # This date, in Brasilia time, will be 2018-04-26 (-02:00)
    time = Time.parse('2018-04-26T02:50:00Z')

    expect(BusinessDays.business_days_from_utc_time(10, time, reference)).to eql(Date.parse("2018-05-11"))
  end
end
