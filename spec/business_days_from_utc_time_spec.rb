require_relative '../lib/business-days'

describe 'test' do
  it '2018-01-02 plus 1 business days should be 2018-02-03' do
    # This date, in Brasilia time, will be 2018-03-02 (-02:00)
    time = Time.parse('2018-01-02T02:50:00Z')

    expect(BusinessDays.business_days_from_utc_time(1, time)).to eql(Time.parse('2018-01-03T02:00:00Z'))
  end

  it '2018-03-01 plus 1 business days should be 2018-03-02' do
    # This date, in Brasilia time, will be 2018-03-01 (-03:00)
    time = Time.parse('2018-03-02T02:50:00Z')

    expect(BusinessDays.business_days_from_utc_time(1, time)).to eql(Time.parse('2018-03-02T03:00:00Z'))
  end

  it '2018-01-04 plus 5 business days should be 2018-01-11' do
    # This date, in Brasilia time, will be 2018-01-04 (-02:00)
    time = Time.parse('2018-01-04T15:00:00Z')

    expect(BusinessDays.business_days_from_utc_time(5, time)).to eql(Time.parse('2018-01-11T02:00:00Z'))
  end

  it '2021-04-30 plus 2 business days should be 2021-05-04' do
    # This date, in Brasilia time, will be 2021-04-30 (-03:00)
    time = Time.parse('2021-04-30T15:00:00Z')

    expect(BusinessDays.business_days_from_utc_time(2, time)).to eql(Time.parse('2021-05-04T03:00:00Z'))
  end

  it '2021-04-26 plus 10 business days should be 2021-05-11' do
    # This date, in Brasilia time, will be 2021-04-26 (-03:00)
    time = Time.parse('2021-04-26T15:00:00Z')

    expect(BusinessDays.business_days_from_utc_time(10, time)).to eql(Time.parse('2021-05-10T03:00:00Z'))
  end

  it '2018-11-02 plus 1 business days should be 2018-11-05' do
    # This date, in Brasilia time, will be 2018-11-02 (-03:00)
    time = Time.parse('2018-11-02T15:00:00Z')

    expect(BusinessDays.business_days_from_utc_time(1, time)).to eql(Time.parse('2018-11-05T02:00:00Z'))
  end

  it '2018-11-03 plus 1 business days should be 2018-11-05' do
    # This date, in Brasilia time, will be 2018-11-03 (-03:00)
    time = Time.parse('2018-11-03T15:00:00Z')

    expect(BusinessDays.business_days_from_utc_time(1, time)).to eql(Time.parse('2018-11-05T02:00:00Z'))
  end

  it '2018-11-04 plus 1 business days should be 2018-11-05' do
    # This date, in Brasilia time, will be 2018-11-04 (-03:00)
    time = Time.parse('2018-11-04T15:00:00Z')

    expect(BusinessDays.business_days_from_utc_time(1, time)).to eql(Time.parse('2018-11-05T02:00:00Z'))
  end

  it '2018-11-05 plus 1 business days should be 2018-11-05' do
    # This date, in Brasilia time, will be 2018-11-05 (-03:00)
    time = Time.parse('2018-11-05T15:00:00Z')

    expect(BusinessDays.business_days_from_utc_time(1, time)).to eql(Time.parse('2018-11-06T02:00:00Z'))
  end

  it '2021-12-30 plus 1 business days should be 2022-01-03' do
    # This date, in Brasilia time, will be 2021-12-30 (-03:00)
    time = Time.parse('2021-12-30T15:00:00Z')

    expect(BusinessDays.business_days_from_utc_time(1, time)).to eql(Time.parse('2022-01-03T03:00:00Z'))
  end

  it '2020-12-30 plus 1 business days should be 2020-12-31 if ignoring latest day of the year' do
    # This date, in Brasilia time, will be 2020-12-30 (-03:00)
    time = Time.parse('2020-12-30T15:00:00Z')

    # Remove latest bank holiday
    BusinessDays.remove_latest_non_bank_business_days

    expect(BusinessDays.business_days_from_utc_time(1, time)).to eql(Time.parse('2020-12-31T03:00:00Z'))
  end
end
