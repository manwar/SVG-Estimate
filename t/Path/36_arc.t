use strict;
use Test::More;
use lib 'lib', '../../lib', '../lib';
use Image::SVG::Transform;

use_ok 'SVG::Estimate::Path::Arc';
my $transform = Image::SVG::Transform->new();
$transform->extract_transforms('scale(5)');
my $arc = SVG::Estimate::Path::Arc->new(
    transformer => $transform,
    start_point     => [275, 25],
    rx              => 30,
    ry              => 30,
    x_axis_rotation => 0,
    sweep_flag      => 0,
    large_arc_flag  => 0,
    x               => 25,
    y               => 35,
);
isa_ok $arc, 'SVG::Estimate::Path::Arc';

is_deeply $arc->start_point, [275, 25], 'arc start point';
cmp_ok $arc->round($arc->length),  '==', 235.451, 'arc length'; #( 2* pi * r / 4);

cmp_ok $arc->round($arc->min_x), '==', 125, 'min_x';
cmp_ok $arc->round($arc->max_x), '==', 275, 'max_x';
cmp_ok $arc->round($arc->min_y), '==', 25, 'min_y';
cmp_ok $arc->round($arc->max_y), '==', 175, 'max_y';

done_testing();

