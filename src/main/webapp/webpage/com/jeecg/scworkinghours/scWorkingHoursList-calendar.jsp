<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>


<link href='plug-in/fullcalendar-3.0.1/fullcalendar.css' rel='stylesheet' />
<link href='plug-in/fullcalendar-3.0.1/fullcalendar.print.css' rel='stylesheet' media='print' />
<script src='plug-in/fullcalendar-3.0.1/lib/moment.min.js'></script>
<script src='plug-in/fullcalendar-3.0.1/fullcalendar.min.js'></script>
<script src='plug-in/fullcalendar-3.0.1/locale-all.js'></script>


<script>

	$(document).ready(function() {
		var initialLocaleCode = 'zh-cn';

		$('#calendar').fullCalendar({
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month'
				//right: 'month,agendaWeek,agendaDay,listMonth'
			},
			defaultDate: '2016-11-24',
			locale: initialLocaleCode,
			buttonIcons: false, // show the prev/next text
			weekNumbers: true,
			navLinks: true, // can click day/week names to navigate views
			editable: true,
			eventLimit: true, // allow "more" link when too many events
			 events: function(start, end, timezone, callback) {
				 
			        $.ajax({
			            url: 'scWorkingHoursController.do?getEvent',
			            dataType: 'json',
			            data: {
			                // our hypothetical feed requires UNIX timestamps
			                start: start.format(),
			                end: end.format()
			            },
			            success: function(data) {
			            	var events = [];
			            	if(data.success && data.obj.length != 0){
			            		
			            		$(data.obj).each(function(index, obj) {
				                    events.push({
				                        title: obj.title,
				                        start: obj.start,
				                        end: obj.end,
				                        color: obj.color,
				                        content: obj.content,
				                        id : obj.id
				                    });
				                });
			            		
			            	}else if(!data.success){
			            		top.layer.msg('获取数据失败');
			            	}
			            	
			                callback(events);
			            }
			        });
			    },
			   dayClick: function(date, allDay, jsEvent, view) { 
				   createwindow("添加事件","scWorkingHoursController.do?goAdd",600,300);   
		        },
			    eventMouseover:function(event){  
			    	/**
	                $("#eventInfo").css("display", "block");  
	                $("#eventInfo").css("top",200);  
	                $("#eventInfo").css("left",300);  
	                $("#name").html(event.projectName);  
	                $("#time").html(event.start.pattern("yyyy-MM-dd") +"至"+event.end.pattern("yyyy-MM-dd"));  
	                $("#location").html(event.location);  
	                $("#participants").html(event.participants);  
	                $("#manager").html(event.manager);  
	                $("#eventInfo").show();  
	                */
	            },  
	            eventMouseout:function(event){  
	                $("#eventInfo").hide();  
	            },
	            eventClick: function(event) { 
	         	   createwindow("编辑事件","scWorkingHoursController.do?goUpdate&id="+event.id,600,300);  
	            }
			
			
			
		});

		// build the locale selector's options
		$.each($.fullCalendar.locales, function(localeCode) {
			$('#locale-selector').append(
				$('<option/>')
					.attr('value', localeCode)
					.prop('selected', localeCode == initialLocaleCode)
					.text(localeCode)
			);
		});

		// when the selected option changes, dynamically change the calendar option
		$('#locale-selector').on('change', function() {
			if (this.value) {
				$('#calendar').fullCalendar('option', 'locale', this.value);
			}
		});
	});

</script>

<style>

	body {
		margin: 0;
		padding: 0;
		font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
		font-size: 14px;
	}

	#top {
		background: #eee;
		border-bottom: 1px solid #ddd;
		padding: 0 10px;
		line-height: 40px;
		font-size: 12px;
	}

	#calendar {
		max-width: 900px;
		margin: 40px auto;
		padding: 0 10px;
	}

</style>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">




<!--  
<div id='top'>

		Locales:<select id='locale-selector'></select>

	</div>
-->
	<div id='calendar'></div>


  
  
  
  
  
 </div>
 <script type="text/javascript">
 
 

 </script>