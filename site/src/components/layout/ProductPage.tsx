import { ProductPageV2 } from "@/components/v2/ProductPageV2";
import { insurancePages } from "@/config/insurancePages";

interface ProductPageProps {
  pageKey: keyof typeof insurancePages;
}

/** Alias to keep existing route components working — delegates to V2. */
export const ProductPage = ({ pageKey }: ProductPageProps) => <ProductPageV2 pageKey={pageKey} />;
