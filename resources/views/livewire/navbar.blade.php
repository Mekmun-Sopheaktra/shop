<div class="d-flex gap-2">
    <div class="d-flex w-100">
        <div class="nav-mobile navbar">
            <div class="hamburger-menu">
                <span class="hamburger-icon"></span>
                <span class="hamburger-icon"></span>
                <span class="hamburger-icon"></span>
            </div>
            Menu
        </div>
    </div>

    <div class="d-flex w-100">
        <div class="nav-mobile-filter navbar">
            <div class="hamburger-menu">
                <span class="hamburger-icon"></span>
                <span class="hamburger-icon"></span>
                <span class="hamburger-icon"></span>
            </div>
            Brand
        </div>
    </div>
</div>

<div class="navbar-container navbar mt-2">
    <ul class="navbar-item gap-2">
        @foreach ($categories as $category)
            <li>
                <a href="{{ url()->current() }}?{{ http_build_query(array_merge(request()->query(), ['category' => $category->slug])) }}"
                   class="{{ $selectedCategory === $category->slug ? 'active' : '' }} font-semibold">
                    {{ ucfirst($category->name) }}
                </a>
            </li>
        @endforeach
    </ul>
</div>
<div class="filter-container navbar mt-2">
    <ul class="navbar-item gap-2">
        @foreach ($brands as $brand)
            <li>
                <a href="{{ url()->current() }}?{{ http_build_query(array_merge(request()->query(), ['brand' => $brand->description])) }}"
                   class="font-semibold">
                    {{ ucfirst($brand->name) }}
                </a>
            </li>
        @endforeach
    </ul>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const hamburgerMenu = document.querySelector('.nav-mobile');
        const navbarContainer = document.querySelector('.navbar-container');
        const filterMenu = document.querySelector('.nav-mobile-filter');
        const filterContainer = document.querySelector('.filter-container');

        function toggleActive(element) {
            element.classList.toggle('active');
        }

        hamburgerMenu.addEventListener('click', function () {
            toggleActive(navbarContainer);
            filterContainer.classList.remove('active'); // Ensure the filter container is closed
        });

        filterMenu.addEventListener('click', function () {
            toggleActive(filterContainer);
            navbarContainer.classList.remove('active'); // Ensure the navbar container is closed
        });
    });
</script>


<style lang="scss">
    .navbar {
        z-index: 1000;
        list-style: none;
        padding: 0;
        background-color: #efefef;
        border: 5px solid #efefef;
        border-radius: 10px;
        position: sticky;
        top: 0;
        overflow: hidden;
        display: flex;
        gap: 0.5rem;
        justify-content: flex-start;
    }

    .navbar li a {
        display: block;
        padding: 14px 16px;
        text-align: center;
        color: black;
        text-decoration: none;
    }

    .navbar li a:hover {
        background-color: white;
    }

    .navbar li a.active {
        background-color: #f17612;
        color: white;
    }

    /* Mobile Styles */
    @media (max-width: 768px) {
        .navbar-item {
            display: flex;
            flex-direction: column;
            width: 100%;
        }

        .nav-mobile {
            display: flex;
            margin-top: 24px;
            width: 100%;
        }
        .nav-mobile-filter {
            display: flex;
            margin-top: 24px;
            width: 100%;
        }
        .navbar-container {
            display: none; /* Initially hide the navbar */
            flex-direction: column;
            align-items: center;
        }

        .navbar-container.active {
            display: flex;
        }

        .filter-container {
            display: none; /* Initially hide the navbar */
            flex-direction: column;
            align-items: center;
        }

        .filter-container.active {
            display: flex;
        }

        .hamburger-menu {
            display: flex;
            flex-direction: column;
            align-items: center;
            cursor: pointer;
            margin: 10px;
        }

        .hamburger-icon {
            width: 30px;
            height: 2px;
            background-color: black;
            margin: 3px 0;
            border-radius: 5px;
        }
    }

    @media (min-width: 769px) {
        .navbar-item {
            display: flex;
        }
        .navbar-container {
            margin: 25px 150px 0;
            justify-content: flex-start;
        }
        .filter-container {
            display: none;
        }
        .nav-mobile {
            display: none;
        }
        .nav-mobile-filter {
            display: none;
        }
    }
</style>
