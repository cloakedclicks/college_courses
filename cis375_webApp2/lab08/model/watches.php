<?php
Class Watch{
    private $id, $brand, $model, $release_year, $price;

    public function __construct($brand, $model, $release_year, $price)
    {
        $this->brand = $brand;
        $this->model = $model;
        $this->release_year = $release_year;
        $this->price = $price;
    }
    public function getId()
    {
        return $this->id;
    }
    public function setId($id)
    {
        $this->id = $id;
    }
    public function getBrand()
    {
        return $this->brand;
    }
    public function setBrand($brand)
    {
        $this->brand = $brand;
    }
    public function getModel()
    {
        return $this->model;
    }
    public function setModel($model)
    {
        $this->model = $model;
    }
    public function getReleaseYear()
    {
        return $this->release_year;
    }
    public function setReleaseYear($release_year)
    {
        $this->release_year = $release_year;
    }
    public function getPrice()
    {
        return $this->price;
    }
    public function setPrice($price)
    {
        $this->price = $price;
    }
}