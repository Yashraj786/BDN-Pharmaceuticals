/* =====================================================================
   BDN PHARMACEUTICALS, PRODUCT DATA
   ---------------------------------------------------------------------
   Edit this file to change what the website shows. Every product card,
   the flagship section, and the footer read from here. No rebuild step,
   just save the file.

   Liquophin's fields below are filled in from the real pack label
   (photographed pack, read directly). Everything marked TODO is a
   placeholder for you to fill in from your own approved literature.
   ===================================================================== */

const BDN_PRODUCTS = [
  {
    id: "liquophin",
    name: "Liquophin",
    subBrand: "Trimurti Plus",
    tagline: "Our best-selling disinfectant, trusted in hospitals, homes, and public spaces across the region.",
    category: "Disinfectant",
    form: "Phenolic disinfectant fluid",
    description:
      "A phenolic-type disinfectant fluid for medical, household, and public sanitation. Five times stronger than carbolic acid, formulated without added quaternary ammonium compounds or mercuric compounds.",
    dilution: "Dilute 1:100 with water before use.",
    packs: ["5 Litre jerrycan", "1 Litre bottle", "500 ml bottle", "200 ml bottle"],
    certifications: ["ISI marked, IS:1061", "ISO 9001:2008 manufacturing"],
    note: "On dilution with water the emulsion may vary in colour depending on the raw material batch. This does not affect the disinfecting property.",
    featured: true,
    rx: false
  },
  {
    id: "product-two",
    name: "TODO: Product Two",
    subBrand: "",
    tagline: "TODO: one short line describing this product.",
    category: "TODO: Category",
    form: "TODO: form, e.g. Liquid concentrate",
    description: "TODO: description from your approved product literature.",
    dilution: "TODO: usage instructions, if applicable.",
    packs: ["TODO: pack size"],
    certifications: ["TODO: certification"],
    note: "",
    featured: false,
    rx: false
  },
  {
    id: "product-three",
    name: "TODO: Product Three",
    subBrand: "",
    tagline: "TODO: one short line describing this product.",
    category: "TODO: Category",
    form: "TODO: form",
    description: "TODO: description from your approved product literature.",
    dilution: "TODO: usage instructions, if applicable.",
    packs: ["TODO: pack size"],
    certifications: ["TODO: certification"],
    note: "",
    featured: false,
    rx: false
  }
];

/* Company details, read from the Liquophin pack label and used across
   the header, footer, and contact section. */
const BDN_COMPANY = {
  name: "BDN Pharmaceuticals",
  tagline: "Precision manufacturing. Products you can trust.",
  address: "W-4, MIDC Industrial Area, Nagpur, Maharashtra, 440028",
  phone: "+91 83789 83884",
  website: "www.bdnpharmaceuticals.com",
  email: "TODO: add a direct enquiry email address",
  hours: "Mon–Sat, 9:30 am – 6:30 pm"
};
