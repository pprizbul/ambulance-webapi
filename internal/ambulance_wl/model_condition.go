/*
 * Waiting List Api
 *
 * Ambulance Waiting List management for Web-In-Cloud system
 *
 * API version: 1.0.0
 * Contact: xprizbul@stuba.sk
 * Generated by: OpenAPI Generator (https://openapi-generator.tech)
 */

package ambulance_wl

// Condition - Describes disease, symptoms, or other reasons of patient   visit
type Condition struct {

	Value string `json:"value"`

	Code string `json:"code,omitempty"`

	// Link to encyclopedical explanation of the patient's condition
	Reference string `json:"reference,omitempty"`

	TypicalDurationMinutes int32 `json:"typicalDurationMinutes,omitempty"`
}
