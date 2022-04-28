<?php

namespace App\Controller\Product;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;

class ListController extends AbstractController
{
    #[Route('/product', name: 'app_product_list')]
    public function __invoke()
    {
        return $this->json([
            'products' => [],
        ]);
    }
}
