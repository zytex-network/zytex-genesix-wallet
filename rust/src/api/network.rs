use flutter_rust_bridge::frb;
pub use zytex_common::network::Network;

#[frb(mirror(Network))]
pub enum _Network {
    Mainnet,
    Testnet,
    Dev,
}
