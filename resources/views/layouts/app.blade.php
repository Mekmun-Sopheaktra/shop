<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>
    <meta charset="utf-8">
    <title>{{ config('app.name', 'Laravel') }}</title>
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="description" content="Shop with Us">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta property="og:title" content="{{ config('app.name', 'Laravel') }}">
    <meta property="og:type" content="shop">
    <meta property="og:url" content="https://shop.mekmunsopheaktra.com/">
    <meta property="og:image" content="{{ asset('assets/imgs/logo/logo.png') }}">
    <link rel="stylesheet" href="{{ asset('assets/css/main.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/css/custom.css') }}">
    @vite(['resources/css/app.css', 'resources/js/app.js'])
    <link rel="shortcut icon" href="{{ asset('assets/imgs/logo/logo.png') }}" type="image/png">
    @livewireStyles
</head>

<body class="font-sans antialiased">
    @include('layouts.header')
    <main class="px-10">
        {{ $slot }}
    </main>
    @include('layouts.footer')
    @livewireScripts
</body>

</html>
