<?php
function getRank($bowlingScore) {
    if ($bowlingScore >= 275) {
        return 'Chuck Norris';
    } else if ($bowlingScore >= 255) {
        return 'Pro';
    } else if ($bowlingScore >= 175) {
        return 'Semi-pro';
    } else if ($bowlingScore >= 125) {
        return 'League';
    } else {
        return 'Wannabe';
    }
}