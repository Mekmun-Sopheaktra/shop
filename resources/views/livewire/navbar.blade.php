<ul class="navbar gap-2">
    @foreach ($categories as $category)
        <li>
            <a href="{{ url()->current() }}?{{ http_build_query(array_merge(request()->query(), ['category' => $category->slug])) }}"
               class="{{ $selectedCategory === $category->slug ? 'active' : '' }} font-semibold">
                {{ ucfirst($category->name) }}
            </a>
        </li>
    @endforeach
</ul>


<style lang="scss">
    @media (max-width: 768px) {
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
            justify-content: flex-start;
            gap: 0.5rem;

            li {
                a {
                    display: block;
                    padding: 14px 16px;
                    text-align: center;
                    color: black;
                    text-decoration: none;

                    &:hover {
                        background-color: white;
                    }

                    &.active {
                        background-color: #f17612;
                        color: white;
                    }
                }
            }
        }
    }

    @media (min-width: 769px) {
        .navbar {
            z-index: 1000;
            list-style: none;
            padding: 0;
            margin: 25px 150px 0;
            background-color: #efefef;
            border: 5px solid #efefef;
            border-radius: 10px;
            position: sticky;
            top: 0;
            overflow: hidden;
            display: flex;
            justify-content: flex-start;
            gap: 0.5rem;

            li {
                a {
                    display: block;
                    padding: 14px 16px;
                    text-align: center;
                    color: black;
                    text-decoration: none;

                    &:hover {
                        background-color: white;
                    }

                    &.active {
                        background-color: #f17612;
                        color: white;
                    }
                }
            }
        }
    }

</style>
