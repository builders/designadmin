<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/date-time.xsl"/>
<xsl:import href="../utilities/calendar-date.xsl"/>
<xsl:import href="../utilities/calendar-master.xsl"/>

<xsl:param name="calendar-xml" select="document('../xml/calendar.xml')"/>
<xsl:param name="holidays-xml" select="document('../xml/holidays.xml')"/>

<xsl:template match="data">	
	<xsl:param name="is-today">
		<xsl:choose>
			<xsl:when test="not($year) or $year='today' or $today = concat($year,'-',$month,'-',$day)">1</xsl:when>
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:param>
	<xsl:param name="not-month">
		<xsl:choose>
			<xsl:when test="not($month)">1</xsl:when>
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:param>
	<xsl:param name="not-day">
		<xsl:choose>
			<xsl:when test="not($day)">1</xsl:when>
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:param>
	<xsl:param name="date">
		<xsl:choose>
			<xsl:when test="not($year) or $year='today'">
				<xsl:value-of select="$today"/>
			</xsl:when>
			<xsl:when test="$year and not($month)">
				<xsl:value-of select="concat($year,'-01-01')"/>
			</xsl:when>
			<xsl:when test="$year and $month and not($day)">
				<xsl:value-of select="concat($year,'-',$month,'-01')"/>
			</xsl:when>
			<xsl:when test="$year and $month and $day">
				<xsl:value-of select="concat(format-number($year,'0000'),'-',format-number($month,'00'),'-',format-number($day,'00'))"/>
			</xsl:when>
		</xsl:choose>
	</xsl:param>
	<xsl:param name="day">
		<xsl:choose>
			<xsl:when test="not($year) or $year='today'">
				<xsl:value-of select="substring($date,9,2)"/>
			</xsl:when>
			<xsl:when test="$month and not($day)">
				<xsl:value-of select="substring($date,9,2)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="format-number($day,'00')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:param>
	<xsl:param name="month">
		<xsl:choose>
			<xsl:when test="not($year) or $year='today'">
				<xsl:value-of select="substring($date,6,2)"/>
			</xsl:when>
			<xsl:when test="not($month) and $year!='today'">
				<xsl:value-of select="'01'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="format-number($month,'00')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:param>
	<xsl:param name="year">
		<xsl:choose>
			<xsl:when test="not($year) or $year='today'">
				<xsl:value-of select="substring($date,1,4)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="format-number($year,'0000')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:param>
	<xsl:param name="month-days">
		<xsl:call-template name="month-days">
			<xsl:with-param name="year" select="$year"/>
			<xsl:with-param name="month" select="$month"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:param name="next-month-days">
		<xsl:call-template name="next-month-days">
			<xsl:with-param name="year" select="$year"/>
			<xsl:with-param name="month" select="$month"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:param name="previous-month-days">
		<xsl:call-template name="previous-month-days">
			<xsl:with-param name="year" select="$year"/>
			<xsl:with-param name="month" select="$month"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:param name="previous-day">
		<xsl:call-template name="previous-day">
			<xsl:with-param name="date" select="$date"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:param name="next-day">
		<xsl:call-template name="next-day">
			<xsl:with-param name="date" select="$date"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:param name="previous-week">
		<xsl:call-template name="previous-week">
			<xsl:with-param name="date" select="$date"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:param name="next-week">
		<xsl:call-template name="next-week">
			<xsl:with-param name="date" select="$date"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:param name="current-date-url">
		<xsl:choose>
			<xsl:when test="$is-today = 1">
				<xsl:value-of select="concat($year,'/',$month,'/',$day,'/')"/>
			</xsl:when>
			<xsl:when test="$year and $not-month = 1">
				<xsl:value-of select="concat($year,'/')"/>
			</xsl:when>
			<xsl:when test="$year and $month and $not-day = 1">
				<xsl:value-of select="concat($year,'/',$month,'/')"/>
			</xsl:when>
			<xsl:when test="$year and $month and $day = 0">
				<xsl:value-of select="concat($year,'/',$month,'/')"/>
			</xsl:when>
			<xsl:when test="$year and $month and $day &gt; 0">
				<xsl:value-of select="concat($year,'/',$month,'/',$day,'/')"/>
			</xsl:when>
		</xsl:choose>
	</xsl:param>
	<xsl:param name="previous-day-url">
		<xsl:value-of select="concat(substring($previous-day,1,4),'/',substring($previous-day,6,2),'/',substring($previous-day,9,2))"/>
	</xsl:param>
	<xsl:param name="next-day-url">
		<xsl:value-of select="concat(substring($next-day,1,4),'/',substring($next-day,6,2),'/',substring($next-day,9,2))"/>
	</xsl:param>
	<xsl:param name="previous-week-url">
		<xsl:value-of select="concat(substring($previous-week,1,4),'/',substring($previous-week,6,2),'/',substring($previous-week,9,2))"/>
	</xsl:param>
	<xsl:param name="next-week-url">
		<xsl:value-of select="concat(substring($next-week,1,4),'/',substring($next-week,6,2),'/',substring($next-week,9,2))"/>
	</xsl:param>
	<xsl:param name="previous-year-url">
		<xsl:choose>
			<xsl:when test="$is-today = 1">
				<xsl:value-of select="concat($year - 1,'/',$month,'/',substring($date,9,2))"/>
			</xsl:when>
			<xsl:when test="$year and $not-month = 1">
				<xsl:value-of select="$year - 1"/>
			</xsl:when>
			<xsl:when test="$year and $month and $not-day = 1">
				<xsl:value-of select="concat($year - 1,'/',$month)"/>
			</xsl:when>
			<xsl:when test="$year and $month and $day and $day = 0">
				<xsl:value-of select="concat($year - 1,'/',$month)"/>
			</xsl:when>
			<xsl:when test="$year and $month and $day and $day > 0">
				<xsl:value-of select="concat($year - 1,'/',$month,'/',$day)"/>
			</xsl:when>
		</xsl:choose>
	</xsl:param>
	<xsl:param name="next-year-url">
		<xsl:choose>
			<xsl:when test="$is-today = 1">
				<xsl:value-of select="concat($year + 1,'/',$month,'/',substring($date,9,2))"/>
			</xsl:when>
			<xsl:when test="$year and $not-month = 1">
				<xsl:value-of select="$year + 1"/>
			</xsl:when>
			<xsl:when test="$year and $month and $not-day = 1">
				<xsl:value-of select="concat($year + 1,'/',$month)"/>
			</xsl:when>
			<xsl:when test="$year and $month and $day and $day = 0">
				<xsl:value-of select="concat($year + 1,'/',$month)"/>
			</xsl:when>
			<xsl:when test="$year and $month and $day and $day > 0">
				<xsl:value-of select="concat($year + 1,'/',$month,'/',$day)"/>
			</xsl:when>
		</xsl:choose>
	</xsl:param>
	<xsl:param name="previous-month-url">
		<xsl:choose>
			<xsl:when test="$month - 1 &lt; 1">
				<xsl:choose>
					<xsl:when test="$is-today = 1">
						<xsl:value-of select="concat($year - 1,'/12/',substring($date,9,2))"/>
					</xsl:when>
					<xsl:when test="($year and $not-month = 1) or ($year and $month and $not-day = 1)">
						<xsl:value-of select="concat($year - 1,'/12')"/>
					</xsl:when>
					<xsl:when test="$year and $month and $day">
						<xsl:value-of select="concat($year - 1,'/12/',$day)"/>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$is-today = 1">
						<xsl:value-of select="concat($year,'/',format-number($month - 1,'00'),'/',substring($date,9,2))"/>
					</xsl:when>
					<xsl:when test="$year and $not-month = 1">
						<xsl:value-of select="concat($year,'/',format-number($month - 1,'00'))"/>
					</xsl:when>
					<xsl:when test="$year and $month and $not-day = 1">
						<xsl:value-of select="concat($year,'/',format-number($month - 1,'00'))"/>
					</xsl:when>
					<xsl:when test="$year and $month and $day = 0">
						<xsl:value-of select="concat($year,'/',format-number($month - 1,'00'))"/>
					</xsl:when>
					<xsl:when test="$year and $month and $day &gt; 0 and $day &lt;= $previous-month-days">
						<xsl:value-of select="concat($year,'/',format-number($month - 1,'00'),'/',$day)"/>
					</xsl:when>
					<xsl:when test="$year and $month and $day &gt; $previous-month-days">
						<xsl:value-of select="concat($year,'/',format-number($month - 1,'00'),'/',$previous-month-days)"/>
					</xsl:when>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:param>
	<xsl:param name="next-month-url">
		<xsl:choose>
			<xsl:when test="$month + 1 &gt; 12">
				<xsl:choose>
					<xsl:when test="$is-today = 1">
						<xsl:value-of select="concat($year + 1,'/01/',substring($date,9,2))"/>
					</xsl:when>
					<xsl:when test="($year and $not-month = 1) or ($year and $month and $not-day = 1)">
						<xsl:value-of select="concat($year + 1,'/01')"/>
					</xsl:when>
					<xsl:when test="$year and $month and $day">
						<xsl:value-of select="concat($year + 1,'/01/',$day)"/>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$is-today = 1">
						<xsl:value-of select="concat($year,'/',format-number($month + 1,'00'),'/',substring($date,9,2))"/>
					</xsl:when>
					<xsl:when test="$year and $not-month = 1">
						<xsl:value-of select="concat($year,'/',format-number($month + 1,'00'))"/>
					</xsl:when>
					<xsl:when test="$year and $month and $not-day = 1">
						<xsl:value-of select="concat($year,'/',format-number($month + 1,'00'))"/>
					</xsl:when>
					<xsl:when test="$year and $month and $day = 0">
						<xsl:value-of select="concat($year,'/',format-number($month + 1,'00'))"/>
					</xsl:when>
					<xsl:when test="$year and $month and $day &gt; 0 and $day &lt;= $next-month-days">
						<xsl:value-of select="concat($year,'/',format-number($month + 1,'00'),'/',$day)"/>
					</xsl:when>
					<xsl:when test="$year and $month and $day &gt; $next-month-days">
						<xsl:value-of select="concat($year,'/',format-number($month + 1,'00'),'/',$next-month-days)"/>
					</xsl:when>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:param>
	<xsl:param name="previous-month-date">
		<xsl:choose>
			<xsl:when test="$month - 1 &lt; 1">
				<xsl:value-of select="concat($year - 1,'-12-00')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($year,'-',format-number($month - 1,'00'),'-00')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:param>
	<xsl:param name="next-month-date">
		<xsl:choose>
			<xsl:when test="$month + 1 &gt; 12">
				<xsl:value-of select="concat($year + 1,'-01-00')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($year,'-',format-number($month + 1,'00'),'-00')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:param>
	<div class="body">
		<xsl:choose>
			<xsl:when test="$year = 'NaN' or $year &lt; 1001 or $year &gt; 3000 or $month &gt; 12 or $month &lt; 1 or $day &gt; 31 or $day &lt; 1">
				<h2>Calendar</h2>
				<p>Please enter a date in the address fields in the form of /calendar/yyyy/mm/dd/ to view a calendar. Or you can find out what the date is <a href="{$root}/calendar/day/today/">today</a>. (This calendar does not calculate dates previous to 1,001 AD or greater than 3,000 AD.)</p>
			</xsl:when>
			<xsl:otherwise>
				<div class="calendar calendar-day">
					<div class="calendar-head">
						<ul class="calendar-menu">
							<li><a href="{$root}/calendar/day/{$previous-day-url}/">Previous Day</a></li>
							<li><a href="{$root}/calendar/day/{$next-day-url}/">Next Day</a></li>
							<li><a href="{$root}/calendar/day/{$previous-week-url}/">Previous Week</a></li>
							<li><a href="{$root}/calendar/day/{$next-week-url}/">Next Week</a></li>
							<li><a href="{$root}/calendar/day/{$previous-month-url}/">Previous Month</a></li>
							<li><a href="{$root}/calendar/day/{$next-month-url}/">Next Month</a></li>
							<li><a href="{$root}/calendar/day/{$previous-year-url}/">Previous Year</a></li>
							<li><a href="{$root}/calendar/day/{$next-year-url}/">Next Year</a></li>
							<li>
								<xsl:if test="$is-today = 1">
									<xsl:attribute name="class">
										<xsl:value-of select="'current'"/>
									</xsl:attribute>
								</xsl:if>
								<a href="{$root}/calendar/day/today/">Today</a>
							</li>
							<li class="current"><a href="{$root}/calendar/day/{$current-date-url}">Day</a></li>
							<li><a href="{$root}/calendar/week/{$current-date-url}">Week</a></li>
							<li><a href="{$root}/calendar/{$current-date-url}">Month</a></li>
							<li><a href="{$root}/calendar/year/{$current-date-url}">Year</a></li>
						</ul>
						<h2>
							<xsl:call-template name="format-month">
								<xsl:with-param name="month" select="$month"/>
								<xsl:with-param name="format" select="'M'"/>
							</xsl:call-template>
							<xsl:text> </xsl:text>
							<xsl:call-template name="format-day">
								<xsl:with-param name="day" select="$day"/>
								<xsl:with-param name="format" select="'x'"/>
							</xsl:call-template>
							<xsl:text>, </xsl:text>
							<xsl:value-of select="$year"/>
						</h2>
					</div>
					<xsl:call-template name="calendar-day">
						<xsl:with-param name="year" select="substring($date,1,4)"/>
						<xsl:with-param name="month" select="substring($date,6,2)"/>
						<xsl:with-param name="day" select="substring($date,9,2)"/>
					</xsl:call-template>
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</div>
</xsl:template>

<xsl:template name="calendar-day">
	<xsl:param name="year" select="$year"/>
	<xsl:param name="month" select="$month"/>
	<xsl:param name="day" select="$day"/>
	<xsl:param name="date" select="concat($year,'-',$month,'-',$day)"/>
	<xsl:param name="this-month-day" select="substring(translate($date, '-', ''),5)"/>
	<xsl:param name="is-holiday">
		<xsl:for-each select="$holidays-xml/iCalendar/vcalendar[@x-wr-calname='Holidays']/vevent[substring(dtstart,5) = $this-month-day][not(rrule/item/@class='byday') and rrule/item[@class='freq']='yearly']">
			<xsl:if test="substring(dtstart,5) = $this-month-day">1</xsl:if>
		</xsl:for-each>
	</xsl:param>
	<table summary="calendar">
		<thead>
			<tr>
				<th>
					<xsl:if test="$is-holiday = 1">
						<xsl:attribute name="class">holiday</xsl:attribute>
						<xsl:value-of select="$holidays-xml/iCalendar/vcalendar[@x-wr-calname='Holidays']/vevent[substring(dtstart,5) = $this-month-day]/summary"/>
					</xsl:if>
				</th>
				<th>
					<xsl:call-template name="get-day-of-the-week-name">
						<xsl:with-param name="date" select="$date"/>
					</xsl:call-template>
					<xsl:text>, </xsl:text>
					<xsl:call-template name="format-date">
						<xsl:with-param name="date" select="$date"/>
						<xsl:with-param name="format" select="'d M, Y'"/>
					</xsl:call-template>
				</th>
			</tr>
		</thead>
		<tbody>
			<xsl:call-template name="calendar-day-hours">
				<xsl:with-param name="year" select="$year"/>
				<xsl:with-param name="month" select="$month"/>
				<xsl:with-param name="day" select="$day"/>
			</xsl:call-template>
		</tbody>
	</table>
</xsl:template>

<xsl:template name="calendar-day-hours">
	<xsl:param name="year" select="$year"/>
	<xsl:param name="month" select="$month"/>
	<xsl:param name="day" select="$day"/>
	<xsl:param name="minutes" select="'00'"/>
	<xsl:param name="am-pm" select="'AM'"/>
	<xsl:param name="count" select="0"/>
	<xsl:param name="hour" select="$count"/>
	<xsl:param name="time" select="concat(format-number($hour,'00'),':',$minutes)"/>
	<xsl:param name="formatted-time">
		<xsl:call-template name="format-time">
			<xsl:with-param name="time" select="$time"/>
			<xsl:with-param name="format" select="'t'"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:param name="total-hours-for-day">
		<xsl:call-template name="total-timesheet-hours">
			<xsl:with-param name="year" select="$year"/>
			<xsl:with-param name="month" select="$month"/>
			<xsl:with-param name="day" select="$day"/>
		</xsl:call-template>
	</xsl:param>
	<tr class="hour-row">
		<td class="hour"><xsl:value-of select="$formatted-time"/></td>
		<td>
			<!-- Hours of the Day -->
			<xsl:for-each select="/data/tickets/year[@value=$year]/month[@value=$month]/entry[substring(start-time,9) = $day][substring($time,1,2) = substring(start-time/@time,1,2)]">
				<p>
					<xsl:call-template name="link-to-timesheet-entry"/>
					(<xsl:value-of select="hours"/>)
				</p>
			</xsl:for-each>
		</td>
	</tr>
	<xsl:if test="$count &lt; 23">
		<xsl:call-template name="calendar-day-hours">
			<xsl:with-param name="year" select="$year"/>
			<xsl:with-param name="month" select="$month"/>
			<xsl:with-param name="day" select="$day"/>
			<xsl:with-param name="minutes" select="$minutes"/>
			<xsl:with-param name="am-pm" select="$am-pm"/>
			<xsl:with-param name="count" select="$count + 1"/>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="$count = 23">
		<tr class="hour-row">
			<td class="hour totals">Total Hours</td>
			<td>
				<xsl:if test="$total-hours-for-day &gt; 0">
					<p>Total Hours: <xsl:value-of select="$total-hours-for-day"/></p>
				</xsl:if>
			</td>
		</tr>
	</xsl:if>
</xsl:template>

<xsl:template name="month-days">
	<xsl:param name="date"/>
	<xsl:param name="year" select="substring($date,1,4)"/>
	<xsl:param name="month" select="substring($date,6,2)"/>
	<xsl:param name="month-int" select="format-number($month,'0')"/>
	<xsl:param name="leap-year">
		<xsl:call-template name="is-leap-year">
			<xsl:with-param name="year" select="$year"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:choose>
		<xsl:when test="$month-int!=2">
			<xsl:value-of select="$calendar-xml/calendar/year/month[@value=$month-int]/@days"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:choose>
				<xsl:when test="$leap-year!=1">
					<xsl:value-of select="$calendar-xml/calendar/year/month[@value=2]/@days"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$calendar-xml/calendar/year/month[@value=2]/@leap-year-days"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="previous-month">
	<xsl:param name="date"/>
	<xsl:param name="year" select="substring($date,1,4)"/>
	<xsl:param name="month" select="substring($date,6,2)"/>
	<xsl:choose>
		<xsl:when test="$month - 1 &lt; 1">12</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="format-number($month - 1,'00')"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="next-month">
	<xsl:param name="date"/>
	<xsl:param name="year" select="substring($date,1,4)"/>
	<xsl:param name="month" select="substring($date,6,2)"/>
	<xsl:choose>
		<xsl:when test="$month + 1 &gt; 12">01</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="format-number($month + 1,'00')"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="previous-month-year">
	<xsl:param name="date"/>
	<xsl:param name="year" select="substring($date,1,4)"/>
	<xsl:param name="month" select="substring($date,6,2)"/>
	<xsl:choose>
		<xsl:when test="$month != 1">
			<xsl:value-of select="$year"/>
		</xsl:when>
		<xsl:when test="$month = 1">
			<xsl:value-of select="$year - 1"/>
		</xsl:when>
		<xsl:otherwise>0</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="next-month-year">
	<xsl:param name="date"/>
	<xsl:param name="year" select="substring($date,1,4)"/>
	<xsl:param name="month" select="substring($date,6,2)"/>
	<xsl:choose>
		<xsl:when test="$month &lt; 12">
			<xsl:value-of select="$year"/>
		</xsl:when>
		<xsl:when test="$month = 12">
			<xsl:value-of select="$year + 1"/>
		</xsl:when>
		<xsl:otherwise>0</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="previous-day">
	<xsl:param name="date"/>
	<xsl:param name="year" select="substring($date,1,4)"/>
	<xsl:param name="month" select="substring($date,6,2)"/>
	<xsl:param name="day" select="substring($date,9,2)"/>
	<xsl:param name="previous-month">
		<xsl:call-template name="previous-month">
			<xsl:with-param name="month" select="$month"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:param name="previous-month-year">
		<xsl:call-template name="previous-month-year">
			<xsl:with-param name="year" select="$year"/>
			<xsl:with-param name="month" select="$month"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:param name="previous-month-days">
		<xsl:call-template name="month-days">
			<xsl:with-param name="year" select="$previous-month-year"/>
			<xsl:with-param name="month" select="$previous-month"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:choose>
		<xsl:when test="$day - 1 &lt; 1 and $month = 1">
			<xsl:value-of select="concat($previous-month-year,'-',$previous-month,'-',format-number($previous-month-days,'00'))"/>
		</xsl:when>
		<xsl:when test="$day - 1 &lt; 1 and $month &gt; 1">
			<xsl:value-of select="concat($year,'-',$previous-month,'-',format-number($previous-month-days,'00'))"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="concat($year,'-',$month,'-',format-number($day - 1,'00'))"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="next-day">
	<xsl:param name="date"/>
	<xsl:param name="year" select="substring($date,1,4)"/>
	<xsl:param name="month" select="substring($date,6,2)"/>
	<xsl:param name="day" select="substring($date,9,2)"/>
	<xsl:param name="month-days">
		<xsl:call-template name="month-days">
			<xsl:with-param name="year" select="$year"/>
			<xsl:with-param name="month" select="$month"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:param name="next-month">
		<xsl:call-template name="next-month">
			<xsl:with-param name="month" select="$month"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:param name="next-month-year">
		<xsl:call-template name="next-month-year">
			<xsl:with-param name="year" select="$year"/>
			<xsl:with-param name="month" select="$month"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:choose>
		<xsl:when test="$day + 1 &gt; $month-days">
			<xsl:value-of select="concat($next-month-year,'-',$next-month,'-01')"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="concat($year,'-',$month,'-',format-number($day + 1,'00'))"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="previous-week">
	<xsl:param name="date"/>
	<xsl:param name="year" select="substring($date,1,4)"/>
	<xsl:param name="month" select="substring($date,6,2)"/>
	<xsl:param name="day" select="substring($date,9,2)"/>
	<xsl:param name="previous-month">
		<xsl:call-template name="previous-month">
			<xsl:with-param name="month" select="$month"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:param name="previous-month-year">
		<xsl:call-template name="previous-month-year">
			<xsl:with-param name="year" select="$year"/>
			<xsl:with-param name="month" select="$month"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:param name="previous-month-days">
		<xsl:call-template name="month-days">
			<xsl:with-param name="year" select="$previous-month-year"/>
			<xsl:with-param name="month" select="$previous-month"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:choose>
		<xsl:when test="$day - 7 &lt; 1 and $month = 1">
			<xsl:value-of select="concat($previous-month-year,'-',$previous-month,'-',format-number($previous-month-days - (7 - $day),'00'))"/>
		</xsl:when>
		<xsl:when test="$day - 7 &lt; 1 and $month &gt; 1">
			<xsl:value-of select="concat($year,'-',$previous-month,'-',format-number($previous-month-days - (7 - $day),'00'))"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="concat($year,'-',$month,'-',format-number($day - 7,'00'))"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="next-week">
	<xsl:param name="date"/>
	<xsl:param name="year" select="substring($date,1,4)"/>
	<xsl:param name="month" select="substring($date,6,2)"/>
	<xsl:param name="day" select="substring($date,9,2)"/>
	<xsl:param name="month-days">
		<xsl:call-template name="month-days">
			<xsl:with-param name="year" select="$year"/>
			<xsl:with-param name="month" select="$month"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:param name="next-month">
		<xsl:call-template name="next-month">
			<xsl:with-param name="month" select="$month"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:param name="next-month-year">
		<xsl:call-template name="next-month-year">
			<xsl:with-param name="year" select="$year"/>
			<xsl:with-param name="month" select="$month"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:choose>
		<xsl:when test="$day + 7 &gt; $month-days">
			<xsl:value-of select="concat($next-month-year,'-',$next-month,'-',format-number($day + 7 - $month-days,'00'))"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="concat($year,'-',$month,'-',format-number($day + 7,'00'))"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="previous-month-days">
	<xsl:param name="date"/>
	<xsl:param name="year" select="substring($date,1,4)"/>
	<xsl:param name="month" select="substring($date,6,2)"/>
	<xsl:param name="previous-month">
		<xsl:call-template name="previous-month">
			<xsl:with-param name="month" select="$month"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:param name="leap-year">
		<xsl:call-template name="is-leap-year">
			<xsl:with-param name="year" select="$year"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:call-template name="month-days">
		<xsl:with-param name="leap-year" select="$leap-year"/>
		<xsl:with-param name="month" select="$previous-month"/>
	</xsl:call-template>
</xsl:template>

<xsl:template name="next-month-days">
	<xsl:param name="date"/>
	<xsl:param name="year" select="substring($date,1,4)"/>
	<xsl:param name="month" select="substring($date,6,2)"/>
	<xsl:param name="next-month">
		<xsl:call-template name="next-month">
			<xsl:with-param name="month" select="$month"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:param name="leap-year">
		<xsl:call-template name="is-leap-year">
			<xsl:with-param name="year" select="$year"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:call-template name="month-days">
		<xsl:with-param name="leap-year" select="$leap-year"/>
		<xsl:with-param name="month" select="$next-month"/>
	</xsl:call-template>
</xsl:template>

<xsl:template name="week-number">
	<xsl:param name="date" select="$today"/>
	<xsl:param name="year" select="substring($date, 1, 4)" />
	<xsl:param name="leap" select="(not($year mod 4) and $year mod 100) or not($year mod 400)" />
	<xsl:param name="month" select="substring($date, 6, 2)" />
	<xsl:param name="day" select="substring($date, 9, 2)" />
	<xsl:param name="month-days">
		<xsl:call-template name="month-days">
			<xsl:with-param name="leap-year" select="$leap"/>
			<xsl:with-param name="month" select="$month"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:param name="days">
		<xsl:choose>
			<xsl:when test="$leap and $month > 2">
				<xsl:value-of select="$month-days + $day + 1" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$month-days + $day" />
			</xsl:otherwise>
	</xsl:choose>
	</xsl:param>
	<xsl:param name="y-1" select="$year - 1" />
	<xsl:param name="day-of-week" 
		select="(($y-1 + floor($y-1 div 4) - floor($y-1 div 100) +
			floor($y-1 div 400) + $days) mod 7) + 1" />
	<xsl:choose>
		<xsl:when test="($day - $day-of-week) mod 7">
			<xsl:value-of select="floor(($day - $day-of-week) div 7) + 2" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="floor(($day - $day-of-week) div 7) + 1" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="link-to-timesheet-entry">
	<xsl:param name="timesheet-entry-date">
		<xsl:call-template name="format-date">
			<xsl:with-param name="date" select="start-time"/>
			<xsl:with-param name="format" select="'x m Y'"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:param name="client-handle" select="client/item/@handle"/>
	<xsl:param name="project-number" select="project/item/@id"/>
	<a href="{$root}/timesheet/ticket/entry/{$client-handle}/{$project-number}/{@id}/"
		title="Entry {@id} | {$timesheet-entry-date} | {client/item}{$project-number} | {function/item} | {hours} hr(s)">
		<xsl:value-of select="title"/>
	</a>
</xsl:template>

<xsl:template name="total-timesheet-hours">
	<xsl:param name="date" select="concat($year,'-',$month,'-',$day)"/>
	<xsl:param name="year" select="substring($date,1,4)"/>
	<xsl:param name="month" select="substring($date,6,2)"/>
	<xsl:param name="day" select="substring($date,9,2)"/>
	<xsl:param name="node-set" select="/data/tickets/year[@value=$year]/month[@value=$month]/entry[substring(start-time,9) = $day]/hours"/>
	<xsl:param name="total" select="sum($node-set)"/>
	<xsl:if test="$total &gt; 0">
		<xsl:value-of select="$total"/>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>