<x-app-layout>
    <section class="mt-50 mb-50">
        <div class="container">
            <div class="row">
                @include('livewire.sidebar')
                <div class="col-lg-9">
                    <div class="shop-product-fillter">
                        <div class="totall-product md:block hidden">
                            <p> We found <strong class="text-brand">{{ $products->total() }}</strong> items for you!</p>
                        </div>
                        <div class="sort-by-product-area">
                            <div class="sort-by-cover">
                                <div class="sort-by-product-wrap">
                                    <div class="sort-by">
                                        <span><i class="fi-rs-apps-sort"></i>Sort by:</span>
                                    </div>
                                    <div class="sort-by-dropdown-wrap">
                                        <span>
                                            @if ($sort === 'latest')
                                                Latest: New Released
                                            @elseif ($sort === 'low-to-high')
                                                Price: Low to High
                                            @elseif ($sort === 'high-to-low')
                                                Price: High to Low
                                            @else
                                                Default Sorting
                                            @endif
                                            <i class="fi-rs-angle-small-down"></i>
                                        </span>
                                    </div>
                                </div>
                                <div class="sort-by-dropdown">
                                    <ul>
                                        <li><a class="{{ $sort === 'latest' ? 'active' : '' }}"
                                                href="{{ url()->current() }}?{{ http_build_query(array_merge(request()->query(), ['sort' => 'latest'])) }}">Latest:
                                                New Released</a></li>
                                        <li><a class="{{ $sort === 'low-to-high' ? 'active' : '' }}"
                                                href="{{ url()->current() }}?{{ http_build_query(array_merge(request()->query(), ['sort' => 'low-to-high'])) }}">Price:
                                                Low to High</a></li>
                                        <li><a class="{{ $sort === 'high-to-low' ? 'active' : '' }}"
                                                href="{{ url()->current() }}?{{ http_build_query(array_merge(request()->query(), ['sort' => 'high-to-low'])) }}">Price:
                                                High to Low</a></li>
                                        <li><a href="{{ route('home') }}">Default Sorting</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row product-grid-3 product-display">
                        @foreach ($products as $p)
                            <div class="col-sm-6 col-md-4 col-lg-3 mb-4">
                                <div class="product-cart-wrap mb-6 border-slate-200">
                                    <div class="product-img-action-wrap">
                                        <div class="product-img product-img-zoom">
                                            <a href="{{ route('product.details', $p->id) }}">
                                                <img class="default-img w-full h-auto" src="{{ asset('storage/'.$p->image) }}" alt="{{ $p->name }}">
                                            </a>
                                        </div>
                                    </div>
                                    <div class="product-content-wrap">
                                        <div class="text-xs text-center border rounded-3xl border-black bg-black text-white p-2">
                                            {{ $p->brief_description }}
                                        </div>
                                        <h2 class="text-center mt-3">
                                            <a href="{{ route('product.details', $p->id) }}" class="text-sm">
                                                {{ $p->name }}
                                            </a>
                                        </h2>
                                        <div class="flex items-center justify-between mt-1">
                                            <div class="d-flex items-center gap-2 mx-auto">
                                                <p class="text-md line-through opacity-50">${{ $p->old_price }}</p>
                                                <p class="text-xl font-bold text-orange-500">${{ $p->price }}</p>
                                            </div>
                                        </div>
                                        <div class="description text-start text-xs mt-1">
                                            {!! $p->description !!}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        @endforeach
                    </div>

                    <!--pagination-->
                    {{ $products->links('pagination::tailwind') }}
                </div>
            </div>
        </div>
    </section>
</x-app-layout>

<style lang="scss">
.description p {
   font-size: 12px;
    line-height: 1.5;
}

.default-img {
    width: 100%;
    height: 100px;
    object-fit: cover;
}
</style>
