<header class="header-area header-style-1 header-height-2 px-3 shadow-sm">
    <div class="header-middle d-lg-block py-3">
        <div class="container">
            <div class="header-wrap flex flex-col md:flex-row justify-between items-center gap-2">
                <div class="logo w-[12rem] md:mb-0">
                    <x-application-logo></x-application-logo>
                </div>

                <div class="search-style-1 w-full md:flex-grow md:px-20">
                    <form action="{{ route('home') }}" class="w-full">
                        <input id="search" name="search" type="text" placeholder="Search for any product, category, brand..." class="w-full"/>
                    </form>
                </div>
            </div>
        </div>
    </div>
</header>
