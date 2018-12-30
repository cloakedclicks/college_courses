<?php

class Validate
{
    private $fields;

    public function __construct() {
        $this->fields = new Fields();
    }

    public function getFields() {
        return $this->fields;
    }

    // Validate a generic text field
    public function text($name, $value, $required = true, $min = 1, $max = 255) {

        // Get Field object
        $field = $this->fields->getField($name);
        // If field is not required and empty, remove errors and exit
        if (!$required && empty($value)) {
            $field->clearErrorMessage();
            return;
        }
        // Check field and set or clear error message
        if ($required && empty($value)) {
            $field->setErrorMessage('This field is required.');
        } else if (strlen($value) < $min) {
            $field->setErrorMessage('The entry did not meet the minimum length requirements for the field.');
        } else if (strlen($value) > $max) {
            $field->setErrorMessage('The entry exceeds the maximum number of characters allowed for the field.');
        } else {
            $field->clearErrorMessage();
        }
    }

    // Validate a field with a generic pattern
    public function pattern($name, $value, $pattern, $message, $required = true) {
        // Get Field object
        $field = $this->fields->getField($name);
        // If field is not required and empty, remove errors and exit
        if (!$required && empty($value)) {
            $field->clearErrorMessage();
            return;
        }
        // Check field and set or clear error message
        $match = preg_match($pattern, $value);
        if ($match === false) {
            $field->setErrorMessage('Error testing field.');
        } else if ($match != 1) {
            $field->setErrorMessage($message);
        } else {
            $field->clearErrorMessage();
        }
    }
}