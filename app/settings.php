<?php

return [
        'settings' => [
            'displayErrorDetails' => true,
            // Twig templates settings
            'view' => [
                'path' => __DIR__ . '/../templates',
                'description' => 'My website',
                'baseUrl' => '/../',
                'twig' => [
                'cache' => false
                ],
            ],
            // Database connection settings
            'db' => [
                'host' => 'locahost',
                'dbname' => 'becode',
                'user' => 'becode',
                'pass' => 'becode'
            ]
        ],
];
