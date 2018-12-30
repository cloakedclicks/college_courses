<?php
function getScores($bowlingScore) {
    if ($bowlingScore >= 90) {
        return 'A';
    } else if ($bowlingScore >= 80 && $bowlingScore <= 89) {
        return 'B';
    } else if ($bowlingScore >= 70 && $bowlingScores <= 79) {
        return 'C';
    } else if ($bowlingScore >= 60 && $bowlingSores <= 69) {
        return 'D';
    } else {
        return 'F';
    }
}