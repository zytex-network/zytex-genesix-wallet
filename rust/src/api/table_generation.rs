use std::ops::ControlFlow;
use std::path::Path;

use flutter_rust_bridge::frb;
use log::debug;
use zytex_common::crypto::ecdlp;
use zytex_wallet::wallet::PRECOMPUTED_TABLES_L1;

use crate::api::progress_report::{add_progress_report, Report};

pub struct LogProgressTableGenerationReportFunction;

impl ecdlp::ProgressTableGenerationReportFunction for LogProgressTableGenerationReportFunction {
    fn report(&self, progress: f64, step: ecdlp::ReportStep) -> ControlFlow<()> {
        let step_str = format!("{:?}", step);
        add_progress_report(Report::TableGeneration {
            progress,
            step: step_str,
            message: None,
        });
        debug!("Progress: {:.2}% on step {:?}", progress * 100.0, step);

        ControlFlow::Continue(())
    }
}

#[frb(sync)]
pub fn precomputed_tables_exist(precomputed_tables_path: String) -> bool {
    let file_path =
        format!("{precomputed_tables_path}precomputed_tables_{PRECOMPUTED_TABLES_L1}.bin");
    return Path::new(&file_path).is_file();
}
