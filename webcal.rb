require 'sinatra'
require 'sinatra/reloader'

set :environment, :production

get '/:y/:m' do
  @year = params[:y].to_i
  @month = params[:m].to_i

  @prevyear = @year - 1
  @nextyear = @year + 1

  @t = "<table border>"
  @t = @t + "<tr><th>Sun</th><th>Mon</th><th>Tue</th><th>Wed</th>"
  @t = @t + "<th>Thu</th><th>Fri</th><th>Sat</th></tr>"

  l = getLastDay(@year, @month)
  h = zeller(@year, @month, l)
  
  d = 1
  6.times do |p|
    @t = @t + "<tr>"
    7.times do |q|
      if p == 0 && q < h
        @t = @t + "<td></td>"
      else
        if d <= l
          @t = @t + "<td>#{d}</td>"
          d += 1
        else
          @t = @t + "<td></td>"
        end
      end
    end
    @t = @t + "</tr>"
    if d > l
      break
    end
  end
  
  @t = @t + "</table>"
  
  erb :moncal
end

def isLeapYear(y)
	if y % 4 == 0 && y % 100 == 0 && y % 400 != 0
		false
	elsif y % 4 == 0
		true
	else
		false
	end
end

def getLastDay(y, m)
	d = Date.new(y, m, -1)
	last_d = d.day
end

def zeller(y, m, d)
	w = %w[0 1 2 3 4 5 6]
	w = w[Date.new(y ,m ,d).wday].to_i
end
