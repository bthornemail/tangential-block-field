/* =========================================================================
 * tangential_blackboard_check.c - C99 SYNTAX VERIFICATION HARNESS
 * Checks compile-time compatibility without exporting binary artifacts.
 * ========================================================================= */
#include "tangential_blackboard.h"

int main(void)
{
    OminoCentroid centroid = {0x00U, 0U};
    TangentialBlackboardContext ctx = {0x1337133713371337ULL, 0x0000ULL};
    uint8_t mirrored = antipodal_orientation_mirror(0x7FU);
    BlackboardChart32 chart = extract_chart_32(mirrored);
    uint64_t token =
        0xDEADBEEFDEADBEEFULL + centroid.centroid_point + chart.chart_index;
    uint64_t next_coord = evaluate_tangential_block_field(&ctx, token);

    return (next_coord == ctx.active_field_axis) ? 0 : 1;
}
