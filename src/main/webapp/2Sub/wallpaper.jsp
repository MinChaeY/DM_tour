<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scheduler Calendar</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        table {
    		table-layout: fixed;
            border-collapse: collapse;
            margin: 0 auto;
            margin-top: 20px;
            width: 100%;
        }

        th, td {
            border: 1px solid #dddddd;
            text-align: center;
            padding: 8px;
            height: 100px;
        }

        .day {
            font-weight: bold;
        }

        .schedule-container {
            overflow-y: auto;
        }

        .schedule {
            color: #1E90FF; /* DodgerBlue */
        }

        .header-cell {
            height: 50px;
            color: white;
            background-color: gray;
        }

        #calendar-container {
            margin-bottom: 20px;
        }

        #schedule-display {
            margin-top: 20px;
        }

        .no-schedule {
            color: red;
            font-weight: bold;
        }
    </style>
    
</head>
<body>
<%-- 헤더 영역 --%>
<div id="header-container"></div>

<%-- 콘텐츠 영역 --%>
<div id="content1">

<h1>Scheduler Calendar</h1>

<div id="calendar-container"></div>
<div id="schedule-display" class="schedule-container"></div>

</div>

<%-- 푸터 영역 --%>
<div id="footer-container"></div>

<script>
	// 헤더 가져오기
	fetch('${pageContext.request.contextPath}/1Main/header.jsp')
	.then(response => response.text())
	.then(data => {
	    document.getElementById('header-container').innerHTML = data;
	});
	
	// 푸터 가져오기
	fetch('${pageContext.request.contextPath}/1Main/footer.jsp')
    .then(response => response.text())
    .then(data => {
        document.getElementById('footer-container').innerHTML = data;
    });
    
    
    document.addEventListener("DOMContentLoaded", function () {
    	adjustContentHeight(); // 페이지 로드 시 높이 조절 함수 호출
        window.addEventListener("resize", adjustContentHeight); // 창 크기 변경 시 높이 조절 함수 호출
        // 현재 날짜 정보 가져오기
        var today = new Date();
        var currentYear = today.getFullYear();
        var currentMonth = today.getMonth();

        // 달력 표시 함수 호출
        displayCalendar(currentYear, currentMonth);
    });

    function displayCalendar(year, month) {
        var calendarContainer = document.getElementById("calendar-container");
        var daysInMonth = new Date(year, month + 1, 0).getDate();
        var firstDayOfWeek = new Date(year, month, 1).getDay();
        var scheduleData = getScheduleData(); // 스케줄 데이터를 가져오는 함수 (별도 구현 필요)

        // 테이블 생성
        var table = document.createElement("table");
        var headerRow = table.insertRow();
        var daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

        // 요일 헤더 추가
        for (var i = 0; i < 7; i++) {
            var cell = headerRow.insertCell();
            cell.innerHTML = daysOfWeek[i];
            cell.className = "header-cell"; // 클래스 추가
        }

        // 날짜 채우기
        var date = 1;
        for (var i = 0; i < 6; i++) {
            var row = table.insertRow();

            for (var j = 0; j < 7; j++) {
                if (i === 0 && j < firstDayOfWeek) {
                    var cell = row.insertCell();
                    cell.innerHTML = "";
                } else if (date > daysInMonth) {
                    break;
                } else {
                    var cell = row.insertCell();
                    cell.innerHTML = "<span class='day'>" + date + "</span>";
                    cell.dataset.date = date;
                    cell.addEventListener("click", function () {
                        var date = this.dataset.date;
                        var scheduleContent = scheduleData[date];
                        displaySchedule(date, scheduleContent);
                    });

                    // 해당 날짜에 스케줄이 있는 경우 색상으로 표시
                    if (scheduleData[date]) {
                        cell.querySelector('.day').style.color = "#1E90FF"; // 날짜(글자) 색상 변경
                    }

                    date++;
                }
            }
        }

        calendarContainer.innerHTML = "";
        calendarContainer.appendChild(table);
    }

    function adjustContentHeight() {
        var headerHeight = document.getElementById('header-container').offsetHeight;
        var footerHeight = document.getElementById('footer-container').offsetHeight;
        var content1 = document.getElementById('content1');
        var windowHeight = window.innerHeight;

        content1.style.minHeight = windowHeight - headerHeight - footerHeight + 'px';
        console.log(headerHeight+", "+footerHeight)
    }

    function displaySchedule(date, scheduleContent) {
        var scheduleDisplay = document.getElementById("schedule-display");

        // 이미 해당 날짜의 스케줄이 표시되어 있다면 숨기기
        if (scheduleDisplay.dataset.activeDate === date) {
            scheduleDisplay.innerHTML = "";
            scheduleDisplay.dataset.activeDate = null;
        } else {
            if (scheduleContent) {
                // 스케줄이 있는 경우
                scheduleDisplay.innerHTML = "<div class='schedule'>" + scheduleContent + "</div>";
            } else {
                // 스케줄이 없는 경우
                scheduleDisplay.innerHTML = "No schedule for this date.";
            }
            scheduleDisplay.dataset.activeDate = date;
        }

        console.log("Active Date:", scheduleDisplay.dataset.activeDate);
        console.log("Clicked Date:", date);
    }

    function getScheduleData() {
        // 스케줄 데이터를 가져오는 로직 구현 (예: 서버에서 데이터를 가져올 수 있음)
        // 반환 형식: {1: "Meeting<br>Meeting<br>Meeting<br>Meeting<br>Meeting<br>Meeting<br>Meeting<br>Meeting<br>Meeting<br>Meeting<br>Meeting<br>Meeting<br>Meeting<br>Meeting<br>Meeting<br>Meeting", 5: "Conference", 15: "Event"}
        return {
        	2: 'TOMORROW X TOGETHER WORLD TOUR',
        	3: 'TOMORROW X TOGETHER WORLD TOUR',
        	5: '공사 예정',
        	6: '공사 예정',
        	7: '공사 예정',
        	8: '공사 예정',
        	9: '공사 예정',
        	10: '공사 예정',
        	11: '공사 예정',
        	12: '공사 예정',
        	13: '공사 예정',
        	14: '공사 예정',
        	15: '공사 예정',
        	16: '공사 예정',
        	17: '공사 예정',
        	18: '공사 예정',
        	19: '공사 예정',
        	20: '공사 예정',
        	21: '공사 예정',
        	22: '공사 예정',
        	23: '공사 예정',
        	24: '공사 예정',
        	25: '공사 예정',
        	26: '공사 예정',
        	27: '공사 예정',
        	28: '공사 예정',
        	29: '공사 예정',
        	30: '공사 예정',
        	31: '공사 예정'
        };
    }
</script>

</body>
</html>
