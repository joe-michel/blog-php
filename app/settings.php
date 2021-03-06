<?php

return [
        'settings' => [
            'displayErrorDetails' => false,
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
                'host' => 'jepsen.local',
                'dbname' => 'lcantini',
                'user' => 'lcantini',
                'pass' => 'lcantini'
            ]
        ],
];
