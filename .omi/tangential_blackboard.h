/* =========================================================================
 * tangential_blackboard.h - BARE-METAL C99 COMPUTE ENGINE
 * Pure representation from first principles, free of memory allocations.
 * ========================================================================= */
#ifndef TANGENTIAL_BLACKBOARD_H
#define TANGENTIAL_BLACKBOARD_H

#include <stdint.h>

#define OMINO_LOCAL_INCIDENCES 4320ULL
#define METATRON_PRE_CLOSURE 0x1D1D1D1D1D1D1D1DULL
#define OMINO_WORD_CONTEXT_MASK 0xFFFFULL

/* ±0: Symbols - Fundamental Tokens Origin Pivot */
typedef struct {
    uint8_t centroid_point;
    uint16_t centroid_azimuth;
} OminoCentroid;

/* Finite Product Field Partition with Eight 32-Position Charts */
typedef struct {
    uint8_t chart_index;
    uint8_t chart_position;
} BlackboardChart32;

/* Invariant System Engine State Mirror */
typedef struct {
    uint64_t active_field_axis;
    uint64_t current_word_context;
} TangentialBlackboardContext;

/* Law 9 - Orientation Relativity Involutive Mirror (x ^ 0x80) */
static inline uint8_t antipodal_orientation_mirror(uint8_t byte_plane_pos)
{
    return (uint8_t)(byte_plane_pos ^ 0x80U);
}

/* Finite Product Chart Extraction: Decomposes p = (r, h, v, s, c) */
static inline BlackboardChart32 extract_chart_32(uint8_t byte_plane_pos)
{
    BlackboardChart32 chart;
    chart.chart_position = (uint8_t)(byte_plane_pos & 0x1FU);
    chart.chart_index = (uint8_t)((byte_plane_pos >> 5U) & 0x07U);
    return chart;
}

/* Circular Left Barrel Shift (mod 64) */
static inline uint64_t omino_rol64(uint64_t val, unsigned int shift)
{
    unsigned int amount = shift & 63U;
    return (val << amount) | (val >> ((64U - amount) & 63U));
}

/* Circular Right Barrel Shift (mod 64) */
static inline uint64_t omino_ror64(uint64_t val, unsigned int shift)
{
    unsigned int amount = shift & 63U;
    return (val >> amount) | (val << ((64U - amount) & 63U));
}

/* Pure Next-State Tangential COBS CONS Blend Specification */
static inline uint64_t evaluate_tangential_block_field(
    TangentialBlackboardContext *ctx,
    uint64_t inbound_block_token)
{
    uint64_t base_4320 = inbound_block_token % OMINO_LOCAL_INCIDENCES;
    uint64_t surface_4320_2 = base_4320 * OMINO_LOCAL_INCIDENCES;
    uint64_t horizon_4320_4 =
        surface_4320_2 * OMINO_LOCAL_INCIDENCES * OMINO_LOCAL_INCIDENCES;
    uint64_t left_torque = omino_rol64(inbound_block_token, 1U);
    uint64_t right_torque = omino_ror64(ctx->active_field_axis, 2U);
    uint64_t blended = left_torque ^ right_torque ^ horizon_4320_4;
    uint64_t next_coordinate = blended ^ METATRON_PRE_CLOSURE;

    ctx->active_field_axis = next_coordinate;
    ctx->current_word_context = next_coordinate & OMINO_WORD_CONTEXT_MASK;

    return next_coordinate;
}

#endif /* TANGENTIAL_BLACKBOARD_H */
