/*=============================================== -*- C++ -*- ==*
 * SOFTPRO SignDoc                                              *
 *                                                              *
 * @(#)SignDocDocument.h                                        *
 *                                                              *
 * Copyright SOFTPRO GmbH                                       *
 * Wilhelmstrasse 34, D-71034 Boeblingen                        *
 * All rights reserved.                                         *
 *                                                              *
 * This software is the confidential and proprietary            *
 * information of SOFTPRO ("Confidential Information"). You     *
 * shall not disclose such Confidential Information and shall   *
 * use it only in accordance with the terms of the license      *
 * agreement you entered into with SOFTPRO.                     *
 *==============================================================*/

/**
 * @file SignDocDocument.h
 * @author ema
 * @version $Name$
 * @brief Class SignDocDocument and friends.
 *
 * This header contains the definition of class SignDocDocument and
 * related classes.
 */

#ifndef SP_SIGNDOCDOCUMENT_H__
#define SP_SIGNDOCDOCUMENT_H__

#include <stddef.h>
#include <string>
#include <vector>
#include <spooc/NonCopyable.h>
#include "SignDocSharedBase.h"

#if defined (_MSC_VER) && defined (SPSD_EXPORT)
#define SPSDEXPORT1 __declspec(dllexport)
#else
#define SPSDEXPORT1
#endif

class SignPKCS7;

namespace de { namespace softpro { namespace spooc {
class Image;
class Images;
class InputStream;
class OutputStream;
}}}

class SPFontCache;

/**
 * @brief Base class for colors.
 */
class SPSDEXPORT1 SignDocColor : private de::softpro::spooc::NonCopyable
{
protected:
  /**
   * @brief Constructor.
   */
  SignDocColor () { }

public:
  /**
   * @brief Destructor.
   */
  virtual ~SignDocColor () { }

  /**
   * @brief Create a copy of this object.
   */
  virtual SignDocColor *clone () const = 0;
};

/**
 * @brief RGB color.
 */
class SPSDEXPORT1 SignDocRGBColor : public SignDocColor
{
public:
  /**
   * @brief Constructor.
   *
   * @param[in] aRed    Red component, 0 through 255 (maximum intensity).
   * @param[in] aGreen  Green component, 0 through 255 (maximum intensity).
   * @param[in] aBlue   Blue component, 0 through 255 (maximum intensity).
   */
  SignDocRGBColor (unsigned char aRed, unsigned char aGreen, unsigned char aBlue)
    : mRed (aRed), mGreen (aGreen), mBlue (aBlue)
  {
  };

  /**
   * @brief Copy constructor.
   *
   * @param[in] aSource  The object to be copied.
   */
  SignDocRGBColor (const SignDocRGBColor &aSource);

  /**
   * @brief Assignment operator
   *
   * @param[in] aSource  The object to be copied.
   */
  SignDocRGBColor &operator = (const SignDocRGBColor &aSource);

  virtual SignDocColor *clone () const;

public:
  unsigned char mRed, mGreen, mBlue;
};

/**
 * @brief Gray color.
 */
class SPSDEXPORT1 SignDocGrayColor : public SignDocColor
{
public:
  /**
   * @brief Constructor.
   *
   * @param[in] aIntensity    0 (black) through 255 (maximum intensity).
   */
  SignDocGrayColor (unsigned char aIntensity)
    : mIntensity (aIntensity)
  {
  };

  /**
   * @brief Copy constructor.
   *
   * @param[in] aSource  The object to be copied.
   */
  SignDocGrayColor (const SignDocGrayColor &aSource);

  /**
   * @brief Assignment operator.
   *
   * @param[in] aSource  The object to be copied.
   */
  SignDocGrayColor &operator = (const SignDocGrayColor &aSource);

  virtual SignDocColor *clone () const;

public:
  unsigned char mIntensity;
};

/**
 * @brief Attributes of a text field used for the construction of the
 *        appearance (PDF documents only).
 *
 * This class represents a PDF default appearance string.
 *
 * Modifying an object of this type does not modify the underlying
 * field or document.  Use SignDocDocument::setTextFieldAttributes()
 * or SignDocField::setTextFieldAttributes() to update the text attributes
 * of a field or of the document.
 *
 * @see SignDocDocument::getTextFieldAttributes(), SignDocDocument::setTextFieldAttributes(), SignDocField::getTextFieldAttributes(), SignDocField::setTextFieldAttributes()
 */
class SPSDEXPORT1 SignDocTextFieldAttributes
{
public:
  class Impl;

public:
  /**
   * @brief Constructor.
   */
  SignDocTextFieldAttributes ();

  /**
   * @brief Copy constructor.
   *
   * @param[in] aSource  The object to be copied.
   */
  SignDocTextFieldAttributes (const SignDocTextFieldAttributes &aSource);

  /**
   * @brief Destructor.
   */
  ~SignDocTextFieldAttributes ();

  /**
   * @brief Assignment operator.
   *
   * @param[in] aSource  The source object.
   */
  SignDocTextFieldAttributes &operator= (const SignDocTextFieldAttributes &aSource);

  /**
   * @brief Efficiently swap this object with another one.
   *
   * @param[in] aOther  The other object.
   */
  void swap (SignDocTextFieldAttributes &aOther);

  /**
   * @brief Check if text field attributes are set or not.
   *
   * If this function returns false for a SignDocTextFieldAttributes
   * object retrieved from a text field, the document's default
   * text field attributes will be used (if present).
   *
   * This function returns false for all SignDocTextFieldAttributes
   * objects retrieved from TIFF documents (but you can set the
   * attributes anyway, making isSet() return true).
   *
   * @return true if any attribute is set, false if no attributes are set.
   *
   * @see isValid()
   */
  bool isSet () const;

  /**
   * @brief Check if the text field attributes are valid.
   *
   * This function does not check if the font name refers to a valid font.
   * This function does not check the string set by setRest().
   *
   * @return true if isSet() would return false or
   *         if all attributes are set and are valid, false otherwise.
   *
   * @see isSet(), setRest()
   */
  bool isValid () const;

  /**
   * @brief Unset all attributes.
   *
   * isSet() will return false.
   */
  void clear ();

  /**
   * @brief Get the name of the font.
   *
   * This function returns an empty string if isSet() would return false.
   *
   * @param[in] aEncoding  The encoding to be used for the return value.
   *
   * @return The name of the font.
   *
   * @see getFontResourceName(), getFontSize(), setFontName()
   */
  std::string getFontName (de::softpro::doc::Encoding aEncoding) const;

  /**
   * @brief Set the name of the font.
   *
   * The font name can be the name of a standard font, the name of an
   * already embedded font, or the name of a font defined by a font
   * configuration file.
   *
   * @param[in] aEncoding  The encoding of @a aFontName.
   * @param[in] aFontName  The new font name.
   *
   * @see getFontName(), setFontSize(), setTextColor(), SignDocDocumentLoader::loadFontConfigFile(), SignDocDocumentLoader::loadFontConfigEnvironment(), SignDocDocumentLoader::loadFontConfigStream()
   */
  void setFontName (de::softpro::doc::Encoding aEncoding,
                    const std::string &aFontName);

  /**
   * @brief Get the resource name of the font.
   *
   * This function returns an empty string if isSet() would return false.
   *
   * Note that setting the resource name is not possible.
   *
   * @param[in] aEncoding  The encoding to be used for the return value.
   *
   * @return The resource name of the font.
   *
   * @see getFontName()
   */
  std::string getFontResourceName (de::softpro::doc::Encoding aEncoding) const;

  /**
   * @brief Get the font size.
   *
   * This function returns 0 if isSet() would return false.
   *
   * @return The font size (in user space units).  If the font size is 0,
   *         the default font size (which depends on the field size)
   *         will be used.
   *
   * @see getFontName(), setFontSize()
   */
  double getFontSize () const;

  /**
   * @brief Set the font size.
   *
   * @param[in] aFontSize  The font size (in user space units).
   *                       If the font size is 0, the default font size
   *                       (which depends on the field size) will be used.
   *
   * @see getFontSize(), setFontName()
   */
  void setFontSize (double aFontSize);

  /**
   * @brief Get the text color.
   *
   * This function returns NULL if isSet() would return false.
   *
   * @return A pointer to an object describing the text color or NULL if
   *         the text color is not available.  The caller is
   *         responsible for destroying the object.
   *
   * @see setTextColor()
   */
  SignDocColor *getTextColor () const;

  /**
   * @brief Set the text color.
   *
   * @param[in] aTextColor  The text color.
   */
  void setTextColor (const SignDocColor &aTextColor);

  /**
   * @brief Get unparsed parts of default appearance string.
   *
   * If this function returns a non-empty string, there are unsupported
   * operators in the default appearance string.
   *
   * @return Concatenated unparsed parts of the default appearance string, ie,
   *         the default appearance string sans font name, font size, and
   *         text color.  If this function returns a non-empty string, it
   *         will start with a space character.
   *
   * @see setRest()
   */
  std::string getRest (de::softpro::doc::Encoding aEncoding) const;

  /**
   * @brief Set unparsed parts of default appearance string.
   *
   * @param[in] aEncoding  The encoding of @a aInput.
   * @param[in] aInput     The new string of unparsed operators.
   *                       If this string is non-empty and does not start
   *                       with a space character, a space character will
   *                       be prepended automatically.
   */
  void setRest (de::softpro::doc::Encoding aEncoding,
                const std::string &aInput);

  /**
   * @brief Internal use only.
   * @internal
   */
  Impl *getImpl ();

  /**
   * @brief Internal use only.
   * @internal
   */
  const Impl *getImpl () const;

private:
  Impl *p;
};

/**
 * @brief One field of a document.
 *
 * Calling member function of this class does not modify the document,
 * use SignDocDocument::setField() to apply your changes to the
 * document or SignDocDocument::addField() to add the field to the
 * document.
 *
 * In PDF documents, a field may have multiple visible "widgets". For
 * instance, a radio button group (radio button field) usually has
 * multiple visible buttons, ie, widgets.
 *
 * A SignDocField object represents the logical field (containing the
 * type, name, value, etc) as well as all its widgets. Each widget has
 * a page number, a coordinate rectangle, and, for some field types,
 * text field attributes.
 *
 * Only one widget of the field is accessible at a time in a
 * SignDocField object; use selectWidget() to select the widget to be
 * operated on.
 *
 * For radio button fields and check box fields, each widget also has
 * a "button value". The button value should remain constant after the
 * document has been created (but it can be changed if needed). The
 * field proper has a value which is either "Off" or one of the button
 * values of its widgets.
 *
 * Each widget of a radio button field or a check box field is either
 * off or on. If all widgets of a radio button field or a check box
 * are off, the field's value is "Off". If at least one widget is on,
 * the field's value is that widget's "button value". As the value of
 * a field must be different for the on and off states of the field,
 * the button values must not be "Off".

 * Check box fields usually have exactly one widget. If that widget's
 * button value is, say, "On", the field's value is either "Off" (for
 * the off state) or "On" (for the on state).
 *
 * Check box fields can have multiple widgets. If all widgets have the
 * same button value, say, "yes", the field's value is either "Off"
 * (for the off state) or "yes" (for the off state). Clicking one
 * widget of the check box field will toggle all widgets of that
 * check box field.
 *
 * Check box fields can have multiple widgets having different button
 * values. If a check box field has two widgets with button values,
 * say, "1" and "2", the field's value is either "Off" (for the off
 * state), "1" (if the first widget is on) or "2" (if the second
 * widget is on).  The two widgets cannot be on at the same time.
 *
 * If a check box field has three widgets with button values, say,
 * "one, "two", and "two", respectively, the field's value is either
 * "Off" (for the off state), "one" (if the first widget is on) or
 * "two" (if the second and third widgets are on). The second and
 * third widgets will always have the same state and that state will
 * never be the same as the state of the first widget.
 * 
 * A radio button field usually has at least two widgets, having
 * different button values. If a radio button field has two widgets
 * with button values, say, "a" and "b", the field's value is either
 * "Off" (for the off state), "a" (if the first widget is on), or "b"
 * (if the second widget is on). Clicking the first widget puts the
 * first widget into the on state and the second one into the off
 * state (and vice versa).
 *
 * Different widgets of a radio button field can have the same
 * button value. The behavior for clicking a widget with non-unique
 * button value depends on the f_RadiosInUnison field flag. If that
 * flag is set (it usually is), widgets having the same button value
 * always have the same on/off state. Clicking one of them will turn
 * all of them on. If the f_RadiosInUnison is not set, clicking one
 * widget will put all others (of the same radio button field) into
 * the off state. See getValueIndex() for details.
 *
 * Signature fields have exactly one widget. Fields of other
 * types must have at least one widget.
 *
 * Other fields such as text fields (except for signature fields) also
 * can have multiple widgets, but all of them display the same value.
 */
class SPSDEXPORT1 SignDocField
{
public:
  class Impl;

public:
  /**
   * @brief Field types.
   *
   * Most field types are supported for PDF documents only.
   */
  enum Type
  {
    t_unknown,              ///< Unknown type.
    t_pushbutton,           ///< Pushbutton (PDF).
    t_check_box,            ///< Check box field (PDF).
    t_radio_button,         ///< Radio button (radio button group) (PDF).
    t_text,                 ///< Text field (PDF).
    t_list_box,             ///< List box (PDF).
    t_signature_digsig,     ///< Digital signature field (Adobe DigSig in PDF, SOFTPRO signature in TIFF).
    t_signature_signdoc,    ///< Digital signature field (traditional SignDoc) (PDF).
    t_combo_box             ///< Combo box (drop-down box) (PDF).
  };

  /**
   * @brief Field flags.
   *
   * See the PDF Reference for the meaning of these flags.
   * Most field flags are supported for PDF documents only.
   *
   * The f_NoToggleToOff flag should be set for all radio button groups.
   * Adobe products seem to ignore this flag being not set.
   *
   * The f_Invisible, f_EnableAddAfterSigning, and f_SinglePage flags
   * cannot be modified.
   *
   * Invisible signature fields (f_Invisible) are invisible (ie, they
   * look as if not inserted) until signed. Warning: signing an invisible
   * signature field in a TIFF file may increase the size of the file
   * substantially.
   *
   * By default, no fields can be inserted into a TIFF document
   * after a signature field has been signed.  The f_EnableAddAfterSigning
   * flag changes this behavior.  (f_EnableAddAfterSigning is ignored
   * for PDF documents.)
   *
   * If the f_EnableAddAfterSigning flag is set, document size
   * increases more during signing this field than when this flaq is
   * not set. Each signature will increase the document size by the
   * initial size of the document (before the first signature was
   * applied), approximately.  That is, the first signature will
   * approximately double the size of the document.
   *
   * Inserting a signature field fails if there already are any
   * signed signature fields that don't have this flag set.
   *
   * By default, signing a signature field signs the complete
   * document, that is, modifications to any page are detected.  For
   * TIFF documents, this behavior can be changed for signature fields
   * that have the f_EnableAddAfterSigning flag set: If the
   * f_SinglePage flag is set, the signature applies only to the page
   * containing the signature field, modifications to other pages
   * won't be detected.  This flag can be used for speeding up
   * verification of signatures.
   *
   * A signature field for which f_EnableAddAfterSigning is not set
   * (in a TIFF document) can only be cleared if no other signature
   * fields that don't have f_EnableAddAfterSigning have been signed
   * after the signature field to be cleared.  Signature fields
   * having f_EnableAddAfterSigning set can always be cleared.
   *
   * @see getFlags(), setFlags(), SignDocDocument::clearSignature()
   */
  enum Flag
  {
    f_ReadOnly          = 1 << 0,  ///< ReadOnly
    f_Required          = 1 << 1,  ///< Required
    f_NoExport          = 1 << 2,  ///< NoExport
    f_NoToggleToOff     = 1 << 3,  ///< NoToggleToOff
    f_Radio             = 1 << 4,  ///< Radio
    f_Pushbutton        = 1 << 5,  ///< Pushbutton
    f_RadiosInUnison    = 1 << 6,  ///< RadiosInUnison

    /**
     * @brief Multiline (for text fields).
     *
     * The value of a text field that has this flag set may contain
     * line breaks encoded as "\r", "\n", or "\r\n".
     *
     * The contents of the text field are top-aligned if this flag is
     * set and vertically centered if this flag is not set.
     */
    f_MultiLine         = 1 << 7,

    f_Password          = 1 << 8,  ///< Password
    f_FileSelect        = 1 << 9,  ///< FileSelect
    f_DoNotSpellCheck   = 1 << 10, ///< DoNotSpellCheck
    f_DoNotScroll       = 1 << 11, ///< DoNotScroll
    f_Comb              = 1 << 12, ///< Comb
    f_RichText          = 1 << 13, ///< RichText
    f_Combo             = 1 << 14, ///< Combo (always set for combo boxes)
    f_Edit              = 1 << 15, ///< Edit (for combo boxes): If this flag is set, the user can enter an arbitrary value.
    f_Sort              = 1 << 16, ///< Sort (for list boxes and combo boxes)
    f_MultiSelect       = 1 << 17, ///< MultiSelect (for list boxes)
    f_CommitOnSelChange = 1 << 18, ///< CommitOnSelChange (for list boxes and combo boxes)
    f_SinglePage        = 1 << 28, ///< Signature applies to the containing page only (TIFF only)
    f_EnableAddAfterSigning = 1 << 29, ///< Signature fields can be inserted after signing this field (TIFF only)
    f_Invisible         = 1 << 30  ///< Invisible (TIFF only)
  };

  /**
   * @brief Annotation flags of a widget.
   *
   * See the PDF Reference for the meaning of these flags.  All these
   * flags are supported for PDF documents only, they are ignored for
   * TIFF documents.
   *
   * @see getWidgetFlags(), setWidgetFlags()
   */
  enum WidgetFlag
  {
    wf_Invisible      = 1 << (1 - 1), ///< do not display non-standard annotation
    wf_Hidden         = 1 << (2 - 1), ///< do not display or print or interact
    wf_Print          = 1 << (3 - 1), ///< print the annotation
    wf_NoZoom         = 1 << (4 - 1), ///< do not scale to match magnification
    wf_NoRotate       = 1 << (5 - 1), ///< do not rotate to match page's rotation
    wf_NoView         = 1 << (6 - 1), ///< do not display or interact
    wf_ReadOnly       = 1 << (7 - 1), ///< do not interact
    wf_Locked         = 1 << (8 - 1), ///< annotation cannot be deleted or modified, but its value can be changed
    wf_ToggleNoView   = 1 << (9 - 1), ///< toggle wf_no_view for certain events
    wf_LockedContents = 1 << (10 - 1) ///< value cannot be changed
  };

  /**
   * @brief Text field justification.
   *
   * @see getJustification(), setJustification()
   */
  enum Justification
  {
    j_none,             ///< Non-text field (justification does not apply).
    j_left,             ///< Left-justified.
    j_center,           ///< Centered.
    j_right             ///< Right-justified.
  };

  /**
   * @brief Fields to be locked when signing this signature field.
   *
   * @see getLockType(), setLockType()
   */
  enum LockType
  {
    lt_na,              ///< Not a signature field.
    lt_none,            ///< Don't lock any fields.
    lt_all,             ///< Lock all fields in the document.
    lt_include,         ///< Lock all lock fields specified by addLockField() etc.
    lt_exclude          ///< Lock all fields except the lock fields specified by addLockField() etc.
  };

  /**
   * @brief Bit masks for getCertSeedValueFlags() and setCertSeedValueFlags().
   */
  enum CertSeedValueFlag
  {
    csvf_SubjectCert = 0x01,    // Adobe bit 1
    csvf_IssuerCert  = 0x02,    // Adobe bit 2
    csvf_Policy      = 0x04,    // Adobe bit 3
    csvf_SubjectDN   = 0x08,    // Adobe bit 4
    csvf_KeyUsage    = 0x20,    // Adobe bit 6
    csvf_URL         = 0x40     // Adobe bit 7
  };

public:
  /**
   * @brief Constructor.
   *
   * The new SignDocField object will have one widget.
   */
  SignDocField ();

  /**
   * @brief Copy constructor.
   *
   * @param[in] aSource  The object to be copied.
   */
  SignDocField (const SignDocField &aSource);

  /**
   * @brief Destructor.
   */
  ~SignDocField ();

  /**
   * @brief Assignment operator.
   *
   * @param[in] aSource  The source object.
   */
  SignDocField &operator= (const SignDocField &aSource);

  /**
   * @brief Efficiently swap this object with another one.
   *
   * @param[in] aOther  The other object.
   */
  void swap (SignDocField &aOther);

  /**
   * @brief Get the name of the field.
   *
   * This function throws de::softpro::spooc::EncodingError if
   * the value cannot be represented using the specified encoding.
   *
   * @param[in] aEncoding  The encoding to be used for the return value.
   *
   * @return The name of the field.
   *
   * @see getAlternateName(), getMappingName(), getNameUTF8(), setName()
   */
  std::string getName (de::softpro::doc::Encoding aEncoding) const;

  /**
   * @brief Get the name of the field as UTF-8-encoded C string.
   *
   * @return The name of the field.  This pointer will become invalid
   *         when setName() is called or this object is destroyed.
   */
  const char *getNameUTF8() const;

  /**
   * @brief Set the name of the field.
   *
   * Different document types impose different
   * restrictions on field names. PDF fields have hierarchical field names
   * with components separated by dots.
   *
   * SignDocDocument::setField() operates on the
   * field having a fully-qualified name which equals the name set by
   * this function. In consequence, SignDocDocument::setField() cannot
   * change the name of a field.
   *
   * This function throws de::softpro::spooc::EncodingError if the
   * value is not correctly encoded according to the specified
   * encoding.
   *
   * @param[in] aEncoding  The encoding of @a aName.
   * @param[in] aName      The name of the field.
   *
   * @see getName(), getNameUTF8(), setAlternateName(), setMappingName()
   */
  void setName (de::softpro::doc::Encoding aEncoding, const std::string &aName);

  /**
   * @brief Get the alternate name of the field.
   *
   * The alternate name (if present) should be used for displaying the
   * field name in a user interface. Currently, only PDF documents
   * support alternate field names.
   * 
   * This function throws de::softpro::spooc::EncodingError if
   * the value cannot be represented using the specified encoding.
   *
   * @param[in] aEncoding  The encoding to be used for the return value.
   *
   * @return The alternate name of the field, empty if the field
   *         does not have an alternate name.
   *
   * @see getMappingName(), getName(), setAlternateName()
   */
  std::string getAlternateName (de::softpro::doc::Encoding aEncoding) const;

  /**
   * @brief Set the alternate name of the field.
   *
   * The alternate name (if present) should be used for displaying the
   * field name in a user interface. Currently, only PDF documents
   * support alternate field names.
   *
   * This function throws de::softpro::spooc::EncodingError if the
   * value is not correctly encoded according to the specified
   * encoding.
   *
   * @param[in] aEncoding  The encoding of @a aName.
   * @param[in] aName      The alternate name of the field, empty to
   *                       remove any alternate field name.
   *
   * @see getAlternateName(), getName(), setMappingName(), setName()
   */
  void setAlternateName (de::softpro::doc::Encoding aEncoding, const std::string &aName);

  /**
   * @brief Get the mapping name of the field.
   *
   * The mapping name (if present) should be used for exporting field
   * data. Currently, only PDF documents support mapping field names.
   * 
   * This function throws de::softpro::spooc::EncodingError if
   * the value cannot be represented using the specified encoding.
   *
   * @param[in] aEncoding  The encoding to be used for the return value.
   *
   * @return The mapping name of the field, empty if the field
   *         does not have an mapping name.
   *
   * @see getAlternateName(), getName(), setMappingName()
   */
  std::string getMappingName (de::softpro::doc::Encoding aEncoding) const;

  /**
   * @brief Set the mapping name of the field.
   *
   * The mapping name (if present) should be used for exporting field
   * data. Currently, only PDF documents support mapping field names.
   *
   * This function throws de::softpro::spooc::EncodingError if the
   * value is not correctly encoded according to the specified
   * encoding.
   *
   * @param[in] aEncoding  The encoding of @a aName.
   * @param[in] aName      The mapping name of the field, empty to
   *                       remove any mapping name.
   *
   * @see getMappingName(), getName(), setAlternateName(), setName()
   */
  void setMappingName (de::softpro::doc::Encoding aEncoding, const std::string &aName);

  /**
   * @brief Get the number of values of the field.
   *
   * Pushbutton fields and signature fields don't have a value,
   * list boxes can have multiple values selected if f_MultiSelect
   * is set.
   *
   * @see getChoiceCount(), getValue()
   */
  int getValueCount () const;

  /**
   * @brief Get a value of the field.
   *
   * Pushbutton fields and signature fields don't have a value, list
   * boxes can have multiple values selected if f_MultiSelect is set.
   *
   * Line breaks for multiline text fields (ie, text fields with flag
   * f_MultiLine set) are encoded as "\r", "\n", or "\r\n".
   *
   * This function throws de::softpro::spooc::EncodingError if
   * the value cannot be represented using the specified encoding.
   *
   * @param[in] aEncoding  The encoding to be used for the return value.
   * @param[in] aIndex     0-based index of the value.
   *
   * @return The selected value of the field or an empty string
   *         if the index is out of range.
   *
   * @see addValue(), clearValues(), getChoiceExport(), getChoiceValue(), getValueCount(), getValueIndex(), getValueUTF8(), removeValue(), setValue()
   */
  std::string getValue (de::softpro::doc::Encoding aEncoding, int aIndex) const;

  /**
   * @brief Get a value of the field.
   *
   * Pushbutton fields and signature fields don't have a value, list
   * boxes can have multiple values selected if f_MultiSelect is set.
   *
   * Line breaks for multiline text fields (ie, text fields with flag
   * f_MultiLine set) are encoded as "\r", "\n", or "\r\n".
   *
   * @param[in] aIndex     0-based index of the value.
   *
   * @return The selected value of the field or an empty string
   *         if the index is out of range.  This pointer will become invalid
   *         when addValue(), clearValues(), removeValue(), or setValue()
   *         is called or this object is destroyed.
   *
   * @see addValue(), clearValues(), getValue(), getValueCount(), getValueIndex(), setValue()
   */
  const char *getValueUTF8 (int aIndex) const;

  /**
   * @brief Clear the values.
   *
   * After calling this function, getValueCount() will return 0
   * and getValueIndex() will return -1.
   *
   * @see addValue(), getValueCount(), getValueIndex(), removeValue()
   */
  void clearValues ();

  /**
   * @brief Add a value to the field.
   *
   * Pushbutton fields and signature fields don't have a value, list
   * boxes can have multiple values selected if f_MultiSelect is set.
   *
   * Line breaks for multiline text fields (ie, text fields with flag
   * f_MultiLine set) are encoded as "\r", "\n", or "\r\n". The behavior
   * for values containing line breaks is undefined if the f_MultiLine
   * flag is not set.
   *
   * After calling this function, getValueIndex() will return -1.
   *
   * This function throws de::softpro::spooc::EncodingError if the
   * value is not correctly encoded according to the specified
   * encoding.
   *
   * @param[in] aEncoding  The encoding of @a aValue.
   * @param[in] aValue     The value to be added.
   *                       Complex scripts are supported,
   *                       see @ref signdocshared_complex_scripts.
   *
   * @see clearValues(), getValue(), getValueIndex(), getValueUTF8(), setValue()
   */
  void addValue (de::softpro::doc::Encoding aEncoding,
                 const std::string &aValue);

  /**
   * @brief Set a value of the field.
   *
   * Pushbutton fields and signature fields don't have a value, list
   * boxes can have multiple values selected if f_MultiSelect is set.
   *
   * After calling this function, getValueIndex() will return -1.
   *
   * Line breaks for multiline text fields (ie, text fields with flag
   * f_MultiLine set) are encoded as "\r", "\n", or "\r\n". The behavior
   * for values containing line breaks is undefined if the f_MultiLine
   * flag is not set.
   *
   * This function throws de::softpro::spooc::EncodingError if the
   * value is not correctly encoded according to the specified
   * encoding.
   *
   * @param[in] aIndex     The 0-based index of the value to be set.
   *                       If @a aIndex equals the current number of
   *                       values, the value will be added.
   * @param[in] aEncoding  The encoding of @a aValue.
   * @param[in] aValue     The value to be set. Complex scripts are supported,
   *                       see @ref signdocshared_complex_scripts.
   *
   * @return true if successful, false if @a aIndex is out of range.
   *
   * @see clearValues(), clickButton(), getValue(), getValueIndex(), getValueUTF8(), setValueIndex()
   */
  bool setValue (int aIndex, de::softpro::doc::Encoding aEncoding,
                 const std::string &aValue);

  /**
   * @brief Set the value of the field.
   *
   * Pushbutton fields and signature fields don't have a value, list
   * boxes can have multiple values selected if f_MultiSelect is set.
   *
   * Line breaks for multiline text fields (ie, text fields with flag
   * f_MultiLine set) are encoded as "\r", "\n", or "\r\n". The behavior
   * for values containing line breaks is undefined if the f_MultiLine
   * flag is not set.
   *
   * Calling this function is equivalent to calling clearValues() and
   * addValue(), but the encoding of @a aValue is checked before
   * modifying this object.
   *
   * After calling this function, getValueIndex() will return -1.
   *
   * This function throws de::softpro::spooc::EncodingError if the
   * value is not correctly encoded according to the specified
   * encoding.
   *
   * @param[in] aEncoding  The encoding of @a aValue.
   * @param[in] aValue     The value to be set. Complex scripts are supported,
   *                       see @ref signdocshared_complex_scripts.
   *
   * @see clearValues(), clickButton(), getValue(), getValueIndex(), getValueUTF8(), setValueIndex()
   */
  void setValue (de::softpro::doc::Encoding aEncoding,
                 const std::string &aValue);

  /**
   * @brief Remove a value from the field.
   *
   * After calling this function, getValueIndex() will return -1.
   *
   * @param[in] aIndex     The 0-based index of the value to be removed.
   *
   * @return true if successful, false if @a aIndex is out of range.
   *
   * @see clearValues(), getValue(), getValueIndex(), getValueUTF8()
   */
  bool removeValue (int aIndex);

  /**
   * @brief Get the current value index.
   *
   * Radio button groups and check box fields can have multiple
   * widgets having the same button value. For check box fields
   * and radio buttons without f_RadiosInUnison set, specifying
   * the selected button by value string is not possible in that
   * case. A 0-based value index can be used to find out which
   * button is selected or to select a button.
   *
   * Radio button groups and check box fields need not use a value
   * index; in fact, they usually don't.
   *
   * SignDocDocument::addField() and SignDocDocument::setField()
   * update the value index if the value of a radio button group
   * or check box field is selected by string (ie, setValue())
   * and the field has ambiguous button names.
   *
   * The "Off" value never has a value index.
   *
   * @note addValue(), clearValues(), and setValue() make the value index
   *       unset (ie, getValueIndex() will return -1).
   *
   * @return the 0-based value index or -1 if the value index is not set.
   *
   * @see clickButton(), getValue(), setValueIndex()
   */
  int getValueIndex () const;

  /**
   * @brief Set the value index.
   *
   * Radio button groups and check box fields can have multiple
   * widgets having the same button value. For check box fields
   * and radio buttons without f_RadiosInUnison set, specifying
   * the selected button by value string is ambiguous in that
   * case. A 0-based value index can be used to find out which
   * button is selected or to select a button.
   *
   * Radio button groups and check box fields need not use a value
   * index; in fact, they usually don't. However, you can always
   * set a value index for radio button groups and check box fields.
   *
   * If the value index is non-negative, SignDocDocument::addField()
   * and SignDocDocument::setField() will use the value index instead
   * of the string value set by setValue().
   *
   * Calling setValueIndex() doesn't affect the return value of
   * getValue() as the value index is used by
   * SignDocDocument::addField() and SignDocDocument::setField()
   * only. However, successful calls to SignDocDocument::addField()
   * and SignDocDocument::setField() will make getValue() return the
   * selected value.
   *
   * For radio button groups with f_RadiosInUnison set and non-unique
   * button values and for check box fields with non-unique button
   * values, for each button value, the lowest index having that
   * button value is the canonical one. After calling
   * SignDocDocument::addField() or SignDocDocument::setField(),
   * getValueIndex() will return the canonical value index.
   *
   * Don't forget to update the value index when adding or removing
   * widgets!
   *
   * SignDocDocument::addField() and SignDocDocument::setField() will
   * fail if the value index is non-negative for fields other than
   * radio button groups and check box fields.
   *
   * The "Off" value never has a value index.
   *
   * @note addValue(), clearValues(), and setValue() make the value index
   *       unset (ie, getValueIndex() will return -1). Therefore, you
   *       don't have to call setValueIndex(-1) to make setValue() take
   *       effect on SignDocDocument::addField() and
   *       SignDocDocument::setField().
   *
   * @param[in] aIndex  the 0-based value index or -1 to make the value
   *                    index unset.
   *
   * @see clickButton(), getValue(), getValueIndex(), setValue()
   */
  void setValueIndex (int aIndex);

  /**
   * @brief Click a check box or a radio button.
   *
   * This function updates both the value (see SetValue()) and the
   * value index (see setValueIndex()) based on the current
   * (non-committed) state of the SignDocField object (not looking at
   * the state of the field in the document). It does nothing for
   * other field types.
   *
   * Adobe products seem to ignore f_NoToggleToOff flag being not set,
   * this function behaves the same way (ie, as if f_NoToggleToOff was
   * set).
   *
   * @note A return value of false does not indicate an error!
   *
   * @param[in] aIndex  The 0-based index of the widget being clicked.
   *
   * @return true if anything has been changed, false if nothing
   *         has been changed (wrong field type, @a aIndex out of
   *         range, radio button already active).
   */
  bool clickButton (int aIndex);

  /**
   * @brief Get the number of available choices for a list box or combo box.
   *
   * List boxes and combo boxes can have multiple possible choices.
   * For other field types, this function returns 0.
   *
   * @return The number of available choices or 0 if not supported for
   *         the type of this field.
   *
   * @see getButtonValue(), getChoiceExport(), getChoiceValue(), getValueCount()
   */
  int getChoiceCount () const;

  /**
   * @brief Get an available choice of a list box or combo box.
   *
   * List boxes and combo boxes can have multiple possible
   * choices. Each choice has a value (which will be displayed) and an
   * export value (which is used for exporting the value of the
   * field). Usually, both values are identical. This function returns
   * one choice value, use getChoiceExport() to get the associated
   * export value.
   *
   * This function throws de::softpro::spooc::EncodingError if
   * the value cannot be represented using the specified encoding.
   *
   * @note getValue() and setValue() use the export value.
   *
   * @param[in] aEncoding  The encoding to be used for the return value.
   * @param[in] aIndex     0-based index of the choice value.
   *
   * @return The selected choice value of the field or an empty string
   *         if the index is out of range.
   *
   * @see addChoice(), clearChoices(), getChoiceExport(), getChoiceValueUTF8(), getChoiceCount(), getButtonValue(), removeChoice(), setChoice()
   */
  std::string getChoiceValue (de::softpro::doc::Encoding aEncoding,
                              int aIndex) const;

  /**
   * @brief Get an available choice of a list box or combo box.
   *
   * List boxes and combo boxes can have multiple possible
   * choices. Each choice has a value (which will be displayed) and an
   * export value (which is used for exporting the value of the
   * field). Usually, both values are identical. This function returns
   * one choice value, use getChoiceExportUTF8() to get the associated
   * export value.
   *
   * @note getValue() and setValue() use the export value.
   *
   * @param[in] aIndex     0-based index of the choice value.
   *
   * @return The selected choice value of the field or an empty string
   *         if the index is out of range.  This pointer will become
   *         invalid when addChoice(), clearChoices(),
   *         removeChoice(), or setChoice() is called or this
   *         object is destroyed.
   *
   * @see addChoice(), clearChoices(), getChoiceCount(), getChoiceExportUTF8(), getChoiceValue(), getButtonValueUTF8(), setChoice()
   */
  const char *getChoiceValueUTF8 (int aIndex) const;

  /**
   * @brief Get the export value for an available choice of a list box or combo box.
   *
   * List boxes and combo boxes can have multiple possible
   * choices. Each choice has a value (which will be displayed) and an
   * export value (which is used for exporting the value of the
   * field).  Usually, both values are identical. This function
   * returns one export value, use getChoiceValue() to get the
   * associated choice value.
   *
   * This function throws de::softpro::spooc::EncodingError if
   * the value cannot be represented using the specified encoding.
   *
   * @note getValue() and setValue() use the export value.
   *
   * @param[in] aEncoding  The encoding to be used for the return value.
   * @param[in] aIndex     0-based index of the export value.
   *
   * @return The selected export value of the field or an empty string
   *         if the index is out of range.
   *
   * @see addChoice(), clearChoices(), getChoiceCount(), getChoiceExportUTF8(), getChoiceValue(), getButtonValue(), removeChoice(), setChoice()
   */
  std::string getChoiceExport (de::softpro::doc::Encoding aEncoding,
                               int aIndex) const;

  /**
   * @brief Get the export value for an available choice of a list box or combo box.
   *
   * List boxes and combo boxes can have multiple possible
   * choices. Each choice has a value (which will be displayed) and an
   * export value (which is used for exporting the value of the
   * field).  Usually, both values are identical. This function
   * returns one export value, use getChoiceValue() to get the
   * associated choice value.
   *
   * @note getValue() and setValue() use the export value.
   *
   * @param[in] aIndex     0-based index of the choice value.
   *
   * @return The selected export value of the field or an empty string
   *         if the index is out of range.  This pointer will become
   *         invalid when addChoice(), clearChoices(),
   *         removeChoice(), or setChoice() is called or this
   *         object is destroyed.
   *
   * @see addChoice(), clearChoices(), getChoiceCount(), getChoiceExport(), getChoiceValueUTF8(), getButtonValueUTF8(), setChoice()
   */
  const char *getChoiceExportUTF8 (int aIndex) const;

  /**
   * @brief Clear the choices of a list box or combo box.
   *
   * After calling this function, getChoiceCount() will return 0.
   *
   * @see addChoice(), getChoiceCount(), removeChoice(), setButtonValue()
   */
  void clearChoices ();

  /**
   * @brief Add a choice to a list box or combo box.
   *
   * This function uses the choice value as export value.
   *
   * This function throws de::softpro::spooc::EncodingError if the
   * value is not correctly encoded according to the specified
   * encoding.
   *
   * @note getValue() and setValue() use the export value.
   *
   * @param[in] aEncoding  The encoding of @a aValue.
   * @param[in] aValue     The choice value and export value to be added.
   *                       Complex scripts are supported,
   *                       see @ref signdocshared_complex_scripts.
   *
   * @see clearChoices(), getChoiceExport(), getChoiceValue(), setChoice(), setButtonValue()
   */
  void addChoice (de::softpro::doc::Encoding aEncoding,
                  const std::string &aValue);

  /**
   * @brief Add a choice to a list box or combo box.
   *
   * This function throws de::softpro::spooc::EncodingError if the
   * value is not correctly encoded according to the specified
   * encoding.
   *
   * @note getValue() and setValue() use the export value.
   *
   * @param[in] aEncoding  The encoding of @a aValue and @a aExport.
   * @param[in] aValue     The choice value to be added.
   *                       Complex scripts are supported,
   *                       see @ref signdocshared_complex_scripts.
   * @param[in] aExport    The export value to be added.
   *
   * @see clearChoices(), getChoiceExport(), getChoiceValue(), setChoice(), setButtonValue()
   */
  void addChoice (de::softpro::doc::Encoding aEncoding,
                  const std::string &aValue, const std::string &aExport);

  /**
   * @brief Set a choice value of a list box or combo box.
   *
   * This function uses the choice value as export value.
   *
   * This function throws de::softpro::spooc::EncodingError if the
   * value is not correctly encoded according to the specified
   * encoding.
   *
   * @note getValue() and setValue() use the export value.
   *
   * @param[in] aIndex     The 0-based index of the choice to be set.
   *                       If @a aIndex equals the current number of
   *                       choice, the value will be added.
   * @param[in] aEncoding  The encoding of @a aValue.
   * @param[in] aValue     The choice value and export value to be set.
   *                       Complex scripts are supported,
   *                       see @ref signdocshared_complex_scripts.
   *
   * @return true if successful, false if @a aIndex is out of range.
   *
   * @see clearChoices(), getChoiceExport(), getChoiceValue(), setButtonValue()
   */
  bool setChoice (int aIndex, de::softpro::doc::Encoding aEncoding,
                  const std::string &aValue);

  /**
   * @brief Set a choice value of a list box or combo box.
   *
   * This function throws de::softpro::spooc::EncodingError if the
   * value is not correctly encoded according to the specified
   * encoding.
   *
   * @note getValue() and setValue() use the export value.
   *
   * @param[in] aIndex     The 0-based index of the choice to be set.
   *                       If @a aIndex equals the current number of
   *                       choice, the value will be added.
   * @param[in] aEncoding  The encoding of @a aValue and @a aExport.
   * @param[in] aValue     The choice value to be set.
   *                       Complex scripts are supported,
   *                       see @ref signdocshared_complex_scripts.
   * @param[in] aExport    The export value to be set.
   *
   * @return true if successful, false if @a aIndex is out of range.
   *
   * @see clearChoices(), getChoiceExport(), getChoiceValue(), setButtonValue()
   */
  bool setChoice (int aIndex, de::softpro::doc::Encoding aEncoding,
                  const std::string &aValue, const std::string &aExport);

  /**
   * @brief Remove a choice from a list box or combo box.
   *
   * @param[in] aIndex     The 0-based index of the choice to be removed.
   *
   * @return true if successful, false if @a aIndex is out of range.
   *
   * @see addChoice(), clearChoices()
   */
  bool removeChoice (int aIndex);

  /**
   * @brief Get the type of the field.
   *
   * The default value is #t_unknown.
   *
   * @return The type of the field.
   *
   * @see setType()
   */
  Type getType () const;

  /**
   * @brief Set the type of the field.
   *
   * The default value is #t_unknown.
   *
   * @param[in] aType  The type of the field.
   *
   * @see getType()
   */
  void setType (Type aType);

  /**
   * @brief Get the flags of the field, see enum #Flag.
   *
   * The default value is 0.
   *
   * @return The flags of the field.
   *
   * @see setFlags()
   */
  int getFlags () const;

  /**
   * @brief Set the flags of the field, see enum #Flag.
   *
   * The default value is 0.
   *
   * @param[in] aFlags  The flags of the field.
   *
   * @see getFlags()
   */
  void setFlags (int aFlags);

  /**
   * @brief Check if this signature field is currently clearable.
   *
   * For some document formats (TIFF), signatures may only be cleared in
   * the reverse order of signing (LIFO).  Use this function to find out
   * whether the signature field is currently clearable (as determined
   * by SignDocDocument::getField() or SignDocDocument::getFields(),
   *
   * @note The value returned by this function does not change over
   * the lifetime of this object and therefore may not reflect the
   * current state if signature fields have been signed or cleared
   * since this object was created.
   *
   * @return true iff this is a signature field that can be cleared now.
   *
   * @see SignDocDocument::getField(), SignDocDocument::getFields()
   */
  bool isCurrentlyClearable () const;

  /**
   * @brief Get maximum length of text field.
   *
   * The default value is -1.
   *
   * @return  The maximum length of text fields or -1 if the field is
   *          not a text field or if the text field does not have a
   *          maximum length.
   *
   * @see setMaxLen()
   */
  int getMaxLen () const;

  /**
   * @brief Set maximum length of text fields.
   *
   * @param[in] aMaxLen  The maximum length (in characters) of the text field
   *                     or -1 for no maximum length.
   *
   * @see getMaxLen()
   */
  void setMaxLen (int aMaxLen);

  /**
   * @brief Get the index of the choice to be displayed in the first
   *        line of a list box.
   *
   * The default value is 0.
   *
   * @return The index of the choice to be displayed in the first line
   *         of a list box or 0 for other field types.
   *
   * @see getChoiceValue(), setTopIndex()
   */
  int getTopIndex () const;

  /**
   * @brief Set the index of the choice to be displayed in the first
   *        line of a list box.
   *
   * This value is ignored for other field types.
   *
   * @param[in] aTopIndex  The index of the choice to be displayed in the
   *                       first line of a list box.
   *
   * @see getChoiceValue(), getTopIndex()
   */
  void setTopIndex (int aTopIndex);

  /**
   * @brief Get the index of the currently selected widget.
   *
   * Initially, the first widget is selected (ie, this function returns
   * 0). However, there is an exception to this rule: SignDocField
   * objects created by SignDocDocument::getFieldsOfPage() can have a
   * different widget selected initially for PDF documents.
   *
   * @return The 0-based index of the currently selected widget.
   *
   * @see selectWidget()
   */
  int getWidget () const;

  /**
   * @brief Get the number of widgets.
   *
   * Signature fields always have exactly one widget.  Radio button
   * fields (radio button groups) usually have one widget per button (but can
   * have more widgets than buttons by having multiple widgets for some or
   * all buttons).
   *
   * @return The number of widgets for this field.
   */
  int getWidgetCount () const;

  /**
   * @brief Select a widget.
   *
   * This function selects the widget to be used by getWidgetFlags(),
   * getPage(), getLeft(), getBottom(), getRight(), getTop(),
   * getButtonValue(), getJustification(), getRotation(),
   * getTextFieldAttributes(), setWidgetFlags(), setPage(), setLeft(),
   * setBottom(), setRight(), setTop(), setButtonValue(),
   * setJustification(), setRotation(), and setTextFieldAttributes().
   *
   * @param[in] aIndex  0-based index of the widget.
   *
   * @return true iff successful.
   *
   * @see clickButton(), getWidgetCount()
   */
  bool selectWidget (int aIndex);

  /**
   * @brief Add a widget to the field.
   *
   * The new widget will be added at the end, ie, calling getWidgetCount()
   * <b>before</b> calling addWidget() yields the index of the widget that
   * will be added.
   *
   * After adding a widget, the new widget will be selected.  You must set
   * the page number and the coordinates in the new widget before calling
   * SignDocDocument::addField() or SignDocDocument::setField().
   *
   * @return true iff successful.
   *
   * @see addChoice(), getWidget(), getWidgetCount(), insertWidget(), removeWidget(), selectWidget()
   */
  bool addWidget ();

  /**
   * @brief Add a widget to the field in front of another widget.
   *
   * The new widget will be inserted at the specified index, ie, the
   * index of the new widget will be @a aIndex.
   *
   * After adding a widget, the new widget will be selected.  You must set
   * the page number and the coordinates in the new widget before calling
   * SignDocDocument::addField() or SignDocDocument::setField().
   *
   * @param[in] aIndex  0-based index of the widget in front of which
   *                    the new widget shall be inserted. You can pass
   *                    the current number of widgets as returned by
   *                    getWidgetCount() to add the new widget to the end
   *                    as addWidget() does.
   *
   * @return true iff successful.
   *
   * @see addWidget(), getWidget(), getWidgetCount(), removeWidget(), selectWidget(), setValueIndex
   */
  bool insertWidget (int aIndex);

  /**
   * @brief Remove a widget from the field.
   *
   * This function fails when there is only one widget. That is, a field
   * always has at least one widget.
   *
   * If the currently selected widget is removed, the following rules apply:
   * - When removing the last widget (the one with index getWidgetCount()-1),
   * the predecessor of the removed widget will be selected.
   * - Otherwise, the index of the selected widget won't change, ie,
   * the successor of the removed widget will be selected.
   * .
   *
   * If the widget to be removed is not selected, the currently selected
   * widget will remain selected.
   *
   * All widgets having an index greater than @a aIndex will have their
   * index decremented by one.
   *
   * @param[in] aIndex  0-based index of the widget to remove.
   *
   * @return true iff successful.
   *
   * @see addWidget(), getWidget(), getWidgetCount(), insertWidget(), selectWidget(), setValueIndex
   */
  bool removeWidget (int aIndex);

  /**
   * @brief Get the annotation flags of the widget, see enum #WidgetFlag.
   *
   * The default value is wf_Print.  The annotation flags are used for
   * PDF documents only.  Currently, the semantics of the annotation
   * flags are ignored by this software (ie, the flags are stored in
   * the document, but they don't have any meaning to this software).
   *
   * @return The annotation flags of the widget.
   *
   * @see selectWidget(), setWidgetFlags()
   */
  int getWidgetFlags () const;

  /**
   * @brief Set the annotation flags of the widget, see enum #WidgetFlag.
   *
   * The default value is wf_Print.  The annotation flags are used for
   * PDF documents only.  Currently, the semantics of the annotation
   * flags are ignored by this software (ie, the flags are stored in
   * the document, but they don't have any meaning to this software).
   *
   * @param[in] aFlags  The annotation flags of the widget.
   *
   * @see getWidgetFlags(), selectWidget()
   */
  void setWidgetFlags (int aFlags);

  /**
   * @brief Get the page number.
   *
   * This function returns the index of the page on which this field
   * occurs (1 for the first page), or 0 if the page number is
   * unknown.
   *
   * @return The 1-based page number or 0 if the page number is unknown.
   *
   * @see selectWidget(), setPage()
   */
  int getPage () const;

  /**
   * @brief Set the page number.
   *
   * This function sets the index of the page on which this field
   * occurs (1 for the first page).
   *
   * By calling SignDocDocument::getField(), setPage(), and
   * SignDocDocument::setField(), you can move a field's widget to
   * another page but be careful because the two pages may have
   * different conversion factors, see
   * SignDocDocument::getConversionFactors().
   *
   * @param[in] aPage  The 1-based page number of the field.
   *
   * @see getPage(), selectWidget()
   */
  void setPage (int aPage);

  /**
   * @brief Get the left coordinate.
   *
   * The origin is in the bottom left corner of the page, see
   * @ref signdocshared_coordinates.
   *
   * @return The left coordinate.
   *
   * @see getBottom(), getRight(), getTop(), selectWidget(), setLeft()
   */
  double getLeft () const;

  /**
   * @brief Set the left coordinate.
   *
   * The origin is in the bottom left corner of the page, see
   * @ref signdocshared_coordinates.
   *
   * @param[in] aLeft  The left coordinate.
   *
   * @see getLeft(), selectWidget(), setBottom(), setRight(), setTop()
   */
  void setLeft (double aLeft);

  /**
   * @brief Get the bottom coordinate.
   *
   * The origin is in the bottom left corner of the page, see
   * @ref signdocshared_coordinates.
   *
   * @return The bottom coordinate.
   *
   * @see getLeft(), getRight(), getTop(), selectWidget(), setBottom()
   */
  double getBottom () const;

  /**
   * @brief Set the bottom coordinate.
   *
   * The origin is in the bottom left corner of the page, see
   * @ref signdocshared_coordinates.
   *
   * @param[in] aBottom  The bottom coordinate.
   *
   * @see getBottom(), selectWidget(), setLeft(), setRight(), setTop()
   */
  void setBottom (double aBottom);

  /**
   * @brief Get the right coordinate.
   *
   * The origin is in the bottom left corner of the page, see
   * @ref signdocshared_coordinates.
   * If coordinates are given in pixels (this is true for TIFF documents),
   * this coordinate is exclusive.
   *
   * @return The right coordinate.
   *
   * @see getBottom(), getLeft(), getTop(), selectWidget(), setRight()
   */
  double getRight () const;

  /**
   * @brief Set the right coordinate.
   *
   * The origin is in the bottom left corner of the page, see
   * @ref signdocshared_coordinates.
   * If coordinates are given in pixels (this is true for TIFF documents),
   * this coordinate is exclusive.
   *
   * @param[in] aRight  The right coordinate.
   *
   * @see getRight(), selectWidget(), setBottom(), setLeft(), setTop()
   */
  void setRight (double aRight);

  /**
   * @brief Get the top coordinate.
   *
   * The origin is in the bottom left corner of the page, see
   * @ref signdocshared_coordinates.
   * If coordinates are given in pixels (this is true for TIFF documents),
   * this coordinate is exclusive.
   *
   * @return The top coordinate.
   *
   * @see getBottom(), getLeft(), getRight(), selectWidget(), setTop()
   */
  double getTop () const;

  /**
   * @brief Set the top coordinate.
   *
   * The origin is in the bottom left corner of the page, see
   * @ref signdocshared_coordinates.
   * If coordinates are given in pixels (this is true for TIFF documents),
   * this coordinate is exclusive.
   *
   * @param[in] aTop  The top coordinate.
   *
   * @see getTop(), selectWidget(), setBottom(), setLeft(), setRight()
   */
  void setTop (double aTop);

  /**
   * @brief Get the button value of a widget of a radio button group or check box.
   *
   * Usually, different radio buttons (widgets) of a radio button group
   * (field) have different values. The radio button group has a value
   * (returned by getValue()) which is either "Off" or one of those
   * values. The individual buttons (widgets) of a check box field can
   * also have different export values.
   *
   * Different radio buttons (widgets) of a radio button group (field)
   * can have the same value; in that case, the radio buttons are linked.
   * The individual buttons of a check box field also can have the same
   * value.
   *
   * @param[in] aEncoding  The encoding to be used for the return value.
   *
   * @return The button value  an empty string (for field types that
   *         don't use button values).
   *
   * @see getChoiceValue(), getValue(), selectWidget(), setButtonValue()
   */
  std::string getButtonValue (de::softpro::doc::Encoding aEncoding) const;

  /**
   * @brief Get the button value of a widget of a radio button group or check box.
   *
   * See getButtonValue() for details.
   *
   * @return The button value  an empty string (for field types that
   *         don't use button values).
   *         This pointer will become invalid when addWidget(),
   *         insertWidget(), removeWidget(), or setButtonValue() is called
   *         or this object is destroyed.
   *
   * @see getButtonValue(), getChoiceValue(), getValue(), selectWidget(), setButtonValue()
   */
  const char *getButtonValueUTF8 () const;

  /**
   * Set the button value of a widget of a radio button group or a check box.
   *
   * Usually, different radio buttons (widgets) of a radio button group
   * (field) have different values. The radio button group has a value
   * (returned by getValue()) which is either "Off" or one of those
   * values. The individual buttons (widgets) of a check box field can
   * also have different export values.
   *
   * Different radio buttons (widgets) of a radio button group (field)
   * can have the same value; in that case, the radio buttons are linked.
   * The individual buttons of a check box field also can have the same
   * value.
   *
   * SignDocDocument::addField() and SignDocDocument::setField()
   * ignore the value set by this function if the field is neither
   * a radio button group nor a check box field.
   *
   * @param[in] aEncoding  The encoding of @a aValue.
   * @param[in] aValue     The value to be set. Must not be empty, must
   *                       not be "Off".
   *
   * @see getButtonValue(), getChoiceValue(), getValue(), selectWidget()
   */
  void setButtonValue (de::softpro::doc::Encoding aEncoding,
                       const std::string &aValue);

  /**
   * @brief Get the justification of the widget.
   *
   * The default value is #j_none.
   *
   * @return The justification of the widget, #j_none for non-text fields.
   *
   * @see selectWidget(), setJustification()
   */
  Justification getJustification () const;

  /**
   * @brief Set the justification of the widget.
   *
   * The default value is #j_none.
   *
   * The justification must be j_none for all field types except
   * for text fields and list boxes.
   *
   * @param[in] aJustification  The justification.
   *
   * @see getJustification(), selectWidget()
   */
  void setJustification (Justification aJustification);

  /**
   * @brief Get the rotation of the widget contents.
   *
   * The rotation is specified in degrees (counter-clockwise).
   * The default value is 0.
   *
   * For instance, if the rotation is 270, left-to right
   * text will display top down.
   *
   * @return The rotation of the widget: 0, 90, 180, or 270.
   *
   * @see selectWidget(), setJustification()
   */
  int getRotation () const;

  /**
   * @brief Set the rotation of the widget contents.
   *
   * The rotation is specified in degrees (counter-clockwise).
   * The default value is 0.
   *
   * For instance, if the rotation is 270, left-to right
   * text will display top down.
   *
   * Currently, the rotation must always be 0 for TIFF documents.
   *
   * @param[in] aRotation  The rotation: 0, 90, 180, or 270.
   *
   * @see getRotation(), selectWidget()
   */
  void setRotation (int aRotation);

  /**
   * @brief Get text field attributes.
   *
   * This function returns an empty string if the field uses the
   * document's default font name for fields.
   *
   * Text fields, signature fields, list boxes, and combo boxes can
   * have text field attributes.
   *
   * @param[in,out] aOutput  This object will be updated.
   *
   * @return true iff successful.
   *
   * @see selectWidget(), setTextFieldAttributes(), SignDocDocument::getTextFieldAttributes()
   */
  bool getTextFieldAttributes (SignDocTextFieldAttributes &aOutput) const;

  /**
   * @brief Set text field attributes.
   *
   * Font name and font size must be specified.  The text color is
   * optional. This function fails if any of the attributes of
   * @a aInput are invalid.
   *
   * Text field attributes can be specified for text fields, signature
   * fields, list boxes, and combo boxes.
   *
   * If SignDocTextFieldAttributes::isSet() returns false for @a
   * aInput, the text field attributes of the field will be removed
   * by SignDocDocument::setField().
   *
   * The following rules apply if the field does not have text field
   * attributes:
   * - If the field inherits text field attributes from a
   *   ancestor field, those will be used by PDF processing software.
   * - Otherwise, if the document has specifies text field attributes (see
   *   SignDocDocument::getTextFieldAttributes()), those will be used
   *   by PDF processing software.
   * - Otherwise, the field is not valid.
   * .
   *
   * To avoid having invalid fields, SignDocDocument::addField() and
   * SignDocDocument::setField() will use text field attributes
   * specifying Helvetica as the font and black for the text color if
   * the field does not inherit text field attributes from an ancestor
   * field or from the document.
   *
   * This function always fails for TIFF documents.
   *
   * @return true iff successful.
   *
   * @see getTextFieldAttributes(), selectWidget()
   */
  bool setTextFieldAttributes (const SignDocTextFieldAttributes &aInput);

  /**
   * @brief Get the lock type.
   *
   * The lock type defines the fields to be locked when signing this
   * signature field.
   *
   * @see getLockFields(), setLockType()
   */
  LockType getLockType () const;

  /**
   * @brief Set the lock type.
   *
   * The lock type defines the fields to be locked when signing this
   * signature field.
   *
   * @see addLockField(), getLockType()
   */
  void setLockType (LockType aLockType);

  /**
   * @brief Number of field names for lt_include and lt_exclude.
   *
   * @see addLockField(), clearLockFields(), getLockField(), getLockFieldUTF8(), removeLockField()
   */
  int getLockFieldCount () const;

  /**
   * @brief Get the name of a lock field.
   *
   * This function throws de::softpro::spooc::EncodingError if
   * the value cannot be represented using the specified encoding.
   *
   * @param[in] aEncoding  The encoding to be used for the return value.
   * @param[in] aIndex     0-based index of the lock field.
   *
   * @return The name of the selected lock field or an empty string
   *         if the index is out of range.
   *
   * @see addLockField(), clearLockFields(), getLockFieldCount(), getLockFieldUTF8(), removeLockField(), setLockField()
   */
  std::string getLockField (de::softpro::doc::Encoding aEncoding,
                            int aIndex) const;

  /**
   * @brief Get the name of a lock field.
   *
   * @param[in] aIndex     0-based index of the lock field.
   *
   * @return The name of the selected lock field or an empty string
   *         if the index is out of range.  This pointer will become invalid
   *         when addLockField(), clearLockFields(), removeLockField(), or setLockField()
   *         is called or this object is destroyed.
   *
   * @see addLockField(), clearLockFields(), getLockFieldCount(), getLockFieldUTF8(), setLockField()
   */
  const char *getLockFieldUTF8 (int aIndex) const;

  /**
   * @brief Clear the lock fields.
   *
   * After calling this function, getLockFieldCount() will return 0.
   *
   * @see addLockField(), getLockFieldCount(), removeLockField()
   */
  void clearLockFields ();

  /**
   * @brief Add a lock field to the field.
   *
   * This function throws de::softpro::spooc::EncodingError if the
   * name is not correctly encoded according to the specified
   * encoding.
   *
   * @param[in] aEncoding  The encoding of @a aName.
   * @param[in] aName      The name of the lock field to be added.
   *
   * @see clearLockFields(), getLockField(), getLockFieldUTF8(), setLockField()
   */
  void addLockField (de::softpro::doc::Encoding aEncoding,
                     const std::string &aName);

  /**
   * @brief Set a lock field.
   *
   * This function throws de::softpro::spooc::EncodingError if the
   * name is not correctly encoded according to the specified
   * encoding.
   *
   * @param[in] aIndex     The 0-based index of the value to be set.
   *                       If @a aIndex equals the current number of
   *                       values, the value will be added.
   * @param[in] aEncoding  The encoding of @a aName.
   * @param[in] aName      The name of the lock field to be set.
   *
   * @return true if successful, false if @a aIndex is out of range.
   *
   * @see clearLockFields(), getLockField(), getLockFieldUTF8()
   */
  bool setLockField (int aIndex, de::softpro::doc::Encoding aEncoding,
                     const std::string &aName);

  /**
   * @brief Set a lock field.
   *
   * Calling this function is equivalent to calling clearLockFields() and
   * addLockField(), but the encoding of @a aName is checked before
   * modifying this object.
   *
   * This function throws de::softpro::spooc::EncodingError if the
   * value is not correctly encoded according to the specified
   * encoding.
   *
   * @param[in] aEncoding  The encoding of @a aName.
   * @param[in] aName      The name of the lock field to be set.
   *
   * @see clearLockFields(), getLockField(), getLockFieldUTF8()
   */
  void setLockField (de::softpro::doc::Encoding aEncoding,
                     const std::string &aName);

  /**
   * @brief Remove a lock field.
   *
   * @param[in] aIndex     The 0-based index of the lock field to be removed.
   *
   * @return true if successful, false if @a aIndex is out of range.
   *
   * @see clearLockFields(), getLockField(), getLockFieldUTF8()
   */
  bool removeLockField (int aIndex);

  /**
   * @brief Get the certificate seed value dictionary flags (/SV/Cert/Ff) of a
   *        signature field, see enum #CertSeedValueFlag.
   *
   * The default value is 0.
   *
   * @return The certificate seed value dictionary flags of the field.
   *
   * @see setCertSeedValueFlags()
   */
  unsigned getCertSeedValueFlags () const;

  /**
   * @brief Set the certificate seed value dictionary flags (/SV/Cert/Ff) of a
   *        signature field, see enum #CertSeedValueFlag.
   *
   * The default value is 0.
   *
   * @param[in] aFlags  The certificate seed value dicitionary flags of
   *                    the field.
   *
   * @see getCertSeedValueFlags()
   */
  void setCertSeedValueFlags (unsigned aFlags);

  /**
   * @brief Number of subject distinguished names in the certificate
   *        seed value dictionary.
   *
   * See the PDF Reference for details.
   *
   * @see addCertSeedValueSubjectDN(), clearCertSeedValueSubjectDNs(), getCertSeedValueSubjectDN(), getCertSeedValueSubjectDNUTF8(), removeCertSeedValueSubjectDN()
   */
  int getCertSeedValueSubjectDNCount () const;

  /**
   * @brief Get a subject distinguished name from the certificate
   *        seed value dictionary.
   *
   * See the PDF Reference for details.
   *
   * This function throws de::softpro::spooc::EncodingError if
   * the value cannot be represented using the specified encoding.
   *
   * @note RFC 4514 requires UTF-8 encoding.
   *
   * @param[in] aEncoding  The encoding to be used for the return value.
   * @param[in] aIndex     0-based index of the subject distinguished name.
   *
   * @return The selected subject distinguished name (formatted according to
   *         RFC 4514) or an empty string if the index is out of range.
   *
   * @see addCertSeedValueSubjectDN(), clearCertSeedValueSubjectDNs(), getCertSeedValueSubjectDNCount(), getCertSeedValueSubjectDNUTF8(), removeCertSeedValueSubjectDN(), setCertSeedValueSubjectDN()
   */
  std::string getCertSeedValueSubjectDN (de::softpro::doc::Encoding aEncoding,
                                         int aIndex) const;

  /**
   * @brief Get a subject distinguished name from the certificate
   *        seed value dictionary.
   *
   * See the PDF Reference for details.
   *
   * @note RFC 4514 requires UTF-8 encoding.
   *
   * @param[in] aIndex     0-based index of the subject distinguished name.
   *
   * @return The selected subject distinguished name (formatted according to
   *         RFC 4514) or an empty string if the index is out of range.
   *         This pointer will become invalid when
   *         addCertSeedValueSubjectDN(), clearCertSeedValueSubjectDNs(),
   *         removeCertSeedValueSubjectDN(), or setCertSeedValueSubjectDN() is
   *         called or this object is destroyed.
   *
   * @see addCertSeedValueSubjectDN(), clearCertSeedValueSubjectDNs(), getCertSeedValueSubjectDNCount(), getCertSeedValueSubjectDNUTF8(), setCertSeedValueSubjectDN()
   */
  const char *getCertSeedValueSubjectDNUTF8 (int aIndex) const;

  /**
   * @brief Remove all subject distinguished names from the certificate
   *        seed value dictionary.
   *
   * See the PDF Reference for details.
   *
   * After calling this function, getCertSeedValueSubjectDNCount() will return 0.
   *
   * @see addCertSeedValueSubjectDN(), getCertSeedValueSubjectDNCount(), removeCertSeedValueSubjectDN()
   */
  void clearCertSeedValueSubjectDNs ();

  /**
   * @brief Add a subject distinguished name to the certificate
   *        seed value dictionary.
   *
   * See the PDF Reference for details.
   *
   * This function throws de::softpro::spooc::EncodingError if the
   * name is not correctly encoded according to the specified
   * encoding.
   *
   * @note RFC 4514 requires UTF-8 encoding.
   *
   * @param[in] aEncoding  The encoding of @a aName.
   * @param[in] aName      The subject distinguished name formatted according
   *                       to RFC 4514.
   *
   * @return true if successful, false if @a aName cannot be parsed.
   *
   * @see clearCertSeedValueSubjectDNs(), getCertSeedValueSubjectDN(), getCertSeedValueSubjectDNUTF8(), setCertSeedValueSubjectDN()
   */
  bool addCertSeedValueSubjectDN (de::softpro::doc::Encoding aEncoding,
                                  const std::string &aName);

  /**
   * @brief Set a subject distinguished name in the certificate
   *        seed value dictionary.
   *
   * See the PDF Reference for details.
   *
   * This function throws de::softpro::spooc::EncodingError if the
   * name is not correctly encoded according to the specified
   * encoding.
   *
   * @note RFC 4514 requires UTF-8 encoding.
   *
   * @param[in] aIndex     The 0-based index of the value to be set.
   *                       If @a aIndex equals the current number of
   *                       values, the value will be added.
   * @param[in] aEncoding  The encoding of @a aName.
   * @param[in] aName      The subject distinguished name formatted according
   *                       to RFC 4514.
   *
   * @return true if successful, false if @a aIndex is out of range or
   *         if @a aName cannot be parsed.
   *
   * @see clearCertSeedValueSubjectDNs(), getCertSeedValueSubjectDN(), getCertSeedValueSubjectDNUTF8()
   */
  bool setCertSeedValueSubjectDN (int aIndex, de::softpro::doc::Encoding aEncoding,
                                  const std::string &aName);

  /**
   * @brief Set a subject distinguished name in the certificate
   *        seed value dictionary.
   *
   * See the PDF Reference for details.
   *
   * Calling this function is equivalent to calling
   * clearCertSeedValueSubjectDNs() and addCertSeedValueSubjectDN(), but the
   * encoding of @a aName is checked before modifying this object.
   *
   * This function throws de::softpro::spooc::EncodingError if the
   * value is not correctly encoded according to the specified
   * encoding.
   *
   * @note RFC 4514 requires UTF-8 encoding.
   *
   * @param[in] aEncoding  The encoding of @a aName.
   * @param[in] aName      The subject distinguished name formatted according
   *                       to RFC 4514.
   *
   * @return true if successful, false if @a aName cannot be parsed.
   *
   * @see clearCertSeedValueSubjectDNs(), getCertSeedValueSubjectDN(), getCertSeedValueSubjectDNUTF8()
   */
  bool setCertSeedValueSubjectDN (de::softpro::doc::Encoding aEncoding,
                                  const std::string &aName);

  /**
   * @brief Remove a subject distinguished name from the certificate
   *        seed value dictionary.
   *
   * See the PDF Reference for details.
   *
   * @param[in] aIndex     The 0-based index of the subject distinguished name to be removed.
   *
   * @return true if successful, false if @a aIndex is out of range.
   *
   * @see clearCertSeedValueSubjectDNs(), getCertSeedValueSubjectDN(), getCertSeedValueSubjectDNUTF8()
   */
  bool removeCertSeedValueSubjectDN (int aIndex);

  /**
   * @brief Number of subject certificates in the certificate seed value
   *        dictionary.
   *
   * See the PDF Reference for details.
   *
   * @see addCertSeedValueSubjectCertificate(), clearCertSeedValueSubjectCertificates(), getCertSeedValueSubjectCertificate(), getCertSeedValueSubjectCertificateUTF8(), removeCertSeedValueSubjectCertificate()
   */
  int getCertSeedValueSubjectCertificateCount () const;

  /**
   * @brief Get a subject certificate of the certificate seed value dictionary.
   *
   * See the PDF Reference for details.
   *
   * @param[in]  aIndex    0-based index of the subject certificate.
   * @param[out] aOutput   The DER-encoded certificate will be stored here.
   *
   * @return true if successful, false if @a aIndex is out of range.
   *
   * @see addCertSeedValueSubjectCertificate(), clearCertSeedValueSubjectCertificates(), getCertSeedValueSubjectCertificateCount(), getCertSeedValueSubjectCertificateUTF8(), removeCertSeedValueSubjectCertificate(), setCertSeedValueSubjectCertificate()
   */
  bool getCertSeedValueSubjectCertificate (int aIndex, std::vector<unsigned char> &aOutput) const;

  /**
   * @brief Remove all subject certificates from the certificate seed value dictionary.
   *
   * See the PDF Reference for details.
   *
   * After calling this function, getCertSeedValueSubjectCertificateCount() will return 0.
   *
   * @see addCertSeedValueSubjectCertificate(), getCertSeedValueSubjectCertificateCount(), removeCertSeedValueSubjectCertificate()
   */
  void clearCertSeedValueSubjectCertificates ();

  /**
   * @brief Add a subject certificate to the certificate seed value dictionary.
   *
   * See the PDF Reference for details.
   *
   * @param[in] aPtr       Pointer to the first octet of the DER-encoded
   *                       certificate.
   * @param[in] aSize      Size in octets of the DER-encoded certificate.
   *
   * @see clearCertSeedValueSubjectCertificates(), getCertSeedValueSubjectCertificate(), getCertSeedValueSubjectCertificateUTF8(), setCertSeedValueSubjectCertificate()
   */
  void addCertSeedValueSubjectCertificate (const void *aPtr, size_t aSize);

  /**
   * @brief Set a subject certificate in the certificate seed value dictionary.
   *
   * See the PDF Reference for details.
   *
   * @param[in] aIndex     0-based index of the subject certificate to be set.
   *                       If @a aIndex equals the current number of
   *                       values, the certificate will be added.
   * @param[in] aPtr       Pointer to the first octet of the DER-encoded
   *                       certificate.
   * @param[in] aSize      Size in octets of the DER-encoded certificate.
   *
   * @return true if successful, false if @a aIndex is out of range.
   *
   * @see clearCertSeedValueSubjectCertificates(), getCertSeedValueSubjectCertificate(), getCertSeedValueSubjectCertificateUTF8()
   */
  bool setCertSeedValueSubjectCertificate (int aIndex, const void *aPtr, size_t aSize);

  /**
   * @brief Set a subject certificate in the certificate seed value dictionary.
   *
   * See the PDF Reference for details.
   *
   * Calling this function is equivalent to calling clearCertSeedValueSubjectCertificates() and
   * addCertSeedValueSubjectCertificate().
   *
   * @param[in] aPtr       Pointer to the first octet of the DER-encoded
   *                       certificate.
   * @param[in] aSize      Size in octets of the DER-encoded certificate.
   *
   * @see clearCertSeedValueSubjectCertificates(), getCertSeedValueSubjectCertificate(), getCertSeedValueSubjectCertificateUTF8()
   */
  void setCertSeedValueSubjectCertificate (const void *aPtr, size_t aSize);

  /**
   * @brief Remove a subject certificate from the certificate seed value
   *        dictionary.
   *
   * See the PDF Reference for details.
   *
   * @param[in] aIndex     The 0-based index of the subject certificate to
   *                       be removed.
   *
   * @return true if successful, false if @a aIndex is out of range.
   *
   * @see clearCertSeedValueSubjectCertificates(), getCertSeedValueSubjectCertificate(), getCertSeedValueSubjectCertificateUTF8()
   */
  bool removeCertSeedValueSubjectCertificate (int aIndex);

  /**
   * @brief Number of issuer certificates in the certificate seed value
   *        dictionary.
   *
   * See the PDF Reference for details.
   *
   * @see addCertSeedValueIssuerCertificate(), clearCertSeedValueIssuerCertificates(), getCertSeedValueIssuerCertificate(), getCertSeedValueIssuerCertificateUTF8(), removeCertSeedValueIssuerCertificate()
   */
  int getCertSeedValueIssuerCertificateCount () const;

  /**
   * @brief Get a issuer certificate of the certificate seed value dictionary.
   *
   * See the PDF Reference for details.
   *
   * @param[in]  aIndex    0-based index of the issuer certificate.
   * @param[out] aOutput   The DER-encoded certificate will be stored here.
   *
   * @return true if successful, false if @a aIndex is out of range.
   *
   * @see addCertSeedValueIssuerCertificate(), clearCertSeedValueIssuerCertificates(), getCertSeedValueIssuerCertificateCount(), getCertSeedValueIssuerCertificateUTF8(), removeCertSeedValueIssuerCertificate(), setCertSeedValueIssuerCertificate()
   */
  bool getCertSeedValueIssuerCertificate (int aIndex, std::vector<unsigned char> &aOutput) const;

  /**
   * @brief Remove all issuer certificates from the certificate seed value dictionary.
   *
   * See the PDF Reference for details.
   *
   * After calling this function, getCertSeedValueIssuerCertificateCount() will return 0.
   *
   * @see addCertSeedValueIssuerCertificate(), getCertSeedValueIssuerCertificateCount(), removeCertSeedValueIssuerCertificate()
   */
  void clearCertSeedValueIssuerCertificates ();

  /**
   * @brief Add a issuer certificate to the certificate seed value dictionary.
   *
   * See the PDF Reference for details.
   *
   * @param[in] aPtr       Pointer to the first octet of the DER-encoded
   *                       certificate.
   * @param[in] aSize      Size in octets of the DER-encoded certificate.
   *
   * @see clearCertSeedValueIssuerCertificates(), getCertSeedValueIssuerCertificate(), getCertSeedValueIssuerCertificateUTF8(), setCertSeedValueIssuerCertificate()
   */
  void addCertSeedValueIssuerCertificate (const void *aPtr, size_t aSize);

  /**
   * @brief Set a issuer certificate in the certificate seed value dictionary.
   *
   * See the PDF Reference for details.
   *
   * @param[in] aIndex     0-based index of the issuer certificate to be set.
   *                       If @a aIndex equals the current number of
   *                       values, the certificate will be added.
   * @param[in] aPtr       Pointer to the first octet of the DER-encoded
   *                       certificate.
   * @param[in] aSize      Size in octets of the DER-encoded certificate.
   *
   * @return true if successful, false if @a aIndex is out of range.
   *
   * @see clearCertSeedValueIssuerCertificates(), getCertSeedValueIssuerCertificate(), getCertSeedValueIssuerCertificateUTF8()
   */
  bool setCertSeedValueIssuerCertificate (int aIndex, const void *aPtr, size_t aSize);

  /**
   * @brief Set a issuer certificate in the certificate seed value dictionary.
   *
   * See the PDF Reference for details.
   *
   * Calling this function is equivalent to calling clearCertSeedValueIssuerCertificates() and
   * addCertSeedValueIssuerCertificate().
   *
   * @param[in] aPtr       Pointer to the first octet of the DER-encoded
   *                       certificate.
   * @param[in] aSize      Size in octets of the DER-encoded certificate.
   *
   * @see clearCertSeedValueIssuerCertificates(), getCertSeedValueIssuerCertificate(), getCertSeedValueIssuerCertificateUTF8()
   */
  void setCertSeedValueIssuerCertificate (const void *aPtr, size_t aSize);

  /**
   * @brief Remove a issuer certificate from the certificate seed value
   *        dictionary.
   *
   * See the PDF Reference for details.
   *
   * @param[in] aIndex     The 0-based index of the issuer certificate to
   *                       be removed.
   *
   * @return true if successful, false if @a aIndex is out of range.
   *
   * @see clearCertSeedValueIssuerCertificates(), getCertSeedValueIssuerCertificate(), getCertSeedValueIssuerCertificateUTF8()
   */
  bool removeCertSeedValueIssuerCertificate (int aIndex);

  /**
   * @brief Number of policy OIDs in the certificate seed value dictionary.
   *
   * See the PDF Reference for details.
   *
   * @see addCertSeedValuePolicy(), clearCertSeedValuePolicies(), getCertSeedValuePolicy(), getCertSeedValuePolicyUTF8(), removeCertSeedValuePolicy()
   */
  int getCertSeedValuePolicyCount () const;

  /**
   * @brief Get a policy OID from the certificate seed value dictionary.
   *
   * This function throws de::softpro::spooc::EncodingError if
   * the value cannot be represented using the specified encoding.
   *
   * See the PDF Reference for details.
   *
   * @note OIDs should be ASCII strings.
   *
   * @param[in] aEncoding  The encoding to be used for the return value.
   * @param[in] aIndex     0-based index of the policy OID.
   *
   * @return The selected policy OID or an empty string if the index
   *         is out of range.
   *
   * @see addCertSeedValuePolicy(), clearCertSeedValuePolicies(), getCertSeedValuePolicyCount(), getCertSeedValuePolicyUTF8(), removeCertSeedValuePolicy(), setCertSeedValuePolicy()
   */
  std::string getCertSeedValuePolicy (de::softpro::doc::Encoding aEncoding,
                                      int aIndex) const;

  /**
   * @brief Get a policy OID from the certificate seed value dictionary.
   *
   * See the PDF Reference for details.
   *
   * @note OIDs should be ASCII strings.
   *
   * @param[in] aIndex     0-based index of the policy OID.
   *
   * @return The selected policy OID or an empty string if the index
   *         is out of range.  This pointer will become invalid when
   *         addCertSeedValuePolicy(), clearCertSeedValuePolicies(),
   *         removeCertSeedValuePolicy(), or setCertSeedValuePolicy() is
   *         called or this object is destroyed.
   *
   * @see addCertSeedValuePolicy(), clearCertSeedValuePolicies(), getCertSeedValuePolicyCount(), getCertSeedValuePolicyUTF8(), setCertSeedValuePolicy()
   */
  const char *getCertSeedValuePolicyUTF8 (int aIndex) const;

  /**
   * @brief Remove all policy OIDs from the certificate seed value dictionary.
   *
   * See the PDF Reference for details.
   *
   * After calling this function, getCertSeedValuePolicyCount() will return 0.
   *
   * @see addCertSeedValuePolicy(), getCertSeedValuePolicyCount(), removeCertSeedValuePolicy()
   */
  void clearCertSeedValuePolicies ();

  /**
   * @brief Add a policy OID to the certificate seed value dictionary.
   *
   * See the PDF Reference for details.
   *
   * This function throws de::softpro::spooc::EncodingError if the
   * name is not correctly encoded according to the specified
   * encoding.
   *
   * @note OIDs should be ASCII strings.
   *
   * @param[in] aEncoding  The encoding of @a aOID.
   * @param[in] aOID       The policy OID.
   *
   * @see clearCertSeedValuePolicies(), getCertSeedValuePolicy(), getCertSeedValuePolicyUTF8(), setCertSeedValuePolicy()
   */
  void addCertSeedValuePolicy (de::softpro::doc::Encoding aEncoding,
                               const std::string &aOID);

  /**
   * @brief Set a policy OID in the certificate seed value dictionary.
   *
   * See the PDF Reference for details.
   *
   * This function throws de::softpro::spooc::EncodingError if the
   * name is not correctly encoded according to the specified
   * encoding.
   *
   * @note OIDs should be ASCII strings.
   *
   * @param[in] aIndex     The 0-based index of the value to be set.
   *                       If @a aIndex equals the current number of
   *                       values, the value will be added.
   * @param[in] aEncoding  The encoding of @a aOID.
   * @param[in] aOID       The policy OID.
   *
   * @return true if successful, false if @a aIndex is out of range.
   *
   * @see clearCertSeedValuePolicies(), getCertSeedValuePolicy(), getCertSeedValuePolicyUTF8()
   */
  bool setCertSeedValuePolicy (int aIndex, de::softpro::doc::Encoding aEncoding,
                               const std::string &aOID);

  /**
   * @brief Set a policy OID in the certificate seed value dictionary.
   *
   * See the PDF Reference for details.
   *
   * Calling this function is equivalent to calling clearCertSeedValuePolicies() and
   * addCertSeedValuePolicy(), but the encoding of @a aOID is checked before
   * modifying this object.
   *
   * This function throws de::softpro::spooc::EncodingError if the
   * value is not correctly encoded according to the specified
   * encoding.
   *
   * @note OIDs should be ASCII strings.
   *
   * @param[in] aEncoding  The encoding of @a aOID.
   * @param[in] aOID       The policy OID.
   *
   * @see clearCertSeedValuePolicies(), getCertSeedValuePolicy(), getCertSeedValuePolicyUTF8()
   */
  void setCertSeedValuePolicy (de::softpro::doc::Encoding aEncoding,
                               const std::string &aOID);

  /**
   * @brief Remove a policy OID from the certificate seed value dictionary.
   *
   * See the PDF Reference for details.
   *
   * @param[in] aIndex     The 0-based index of the policy OID to be removed.
   *
   * @return true if successful, false if @a aIndex is out of range.
   *
   * @see clearCertSeedValuePolicies(), getCertSeedValuePolicy(), getCertSeedValuePolicyUTF8()
   */
  bool removeCertSeedValuePolicy (int aIndex);

  /**
   * @brief Get the URL of the RFC 3161 time-stamp server from the
   *        signature field seed value dictionary.
   *
   * This function throws de::softpro::spooc::EncodingError if
   * the value cannot be represented using the specified encoding.
   *
   * @note The URL should be an ASCII string.
   *
   * @param[in] aEncoding  The encoding to be used for the return value.
   *
   * @return The URL of the time-stamp server or an empty string if
   *         no time-stamp server is defined.
   *
   * @see getSeedValueTimeStampRequired(), setSeedValueTimeStamp()
   */
  std::string getSeedValueTimeStampServerURL (de::softpro::doc::Encoding aEncoding) const;

  /**
   * @brief This function gets a flag from the signature field seed value
   *        dictionary that indicates whether a time stamp is required or
   *        not for the signature.
   *
   * If this function returns true, the URL returned by
   * getSeedValueTimeStampServerURL() will be used to add a time
   * stamp to the signature when signing.
   *
   * @return false if a time stamp is not required, true if a time stamp
   *         is required.
   *
   * @see getSeedValueTimeStampServerURL()
   */
  bool getSeedValueTimeStampRequired () const;

  /**
   * @brief Set the URL of an RFC 3161 time-stamp server in the
   *        signature field seed value dictionary.
   *
   * This function throws de::softpro::spooc::EncodingError if the
   * name is not correctly encoded according to the specified
   * encoding.
   *
   * @note URLs must be ASCII strings.
   *
   * @param[in] aEncoding  The encoding of @a aURL.
   * @param[in] aURL       The URL (must be ASCII), empty for no time-stamp
   *                       server. Must be non-empty if @a aRequired is true.
   *                       The scheme must be http or https.
   * @param[in] aRequired  true if a time stamp is required, false if a
   *                       time stamp is not required.
   *
   * @return true if successful, false if @a aURL is invalid.
   *
   * @see getSeedValueTimeStampRequired(), getSeedValueTimeStampServerURL()
   */
  bool setSeedValueTimeStamp (de::softpro::doc::Encoding aEncoding,
                              const std::string &aURL, bool aRequired);

  /**
   * @brief Get color used for empty signature field in TIFF document.
   *
   * The default value is white.
   *
   * @return The color used for empty signature field in TIFF document.
   *         The return value is not defined for other cases.
   *
   * @see setEmptyFieldColor()
   */
  SignDocRGBColor getEmptyFieldColor () const;

  /**
   * @brief Set color used for empty signature field in TIFF document.
   *
   * The default value is white.  For non-TIFF documents, the value
   * set by this function is ignored.  The value is also ignored if
   * compatibility with version 1.12 and earlier is requested.
   *
   * @see getEmptyFieldColor(), SignDocDocument::setCompatibility()
   */
  void setEmptyFieldColor (const SignDocRGBColor &aColor);

  /**
   * @brief Internal use only.
   * @internal
   */
  Impl *getImpl ();

  /**
   * @brief Internal use only.
   * @internal
   */
  const Impl *getImpl () const;

private:
  Impl *p;
};

/**
 * @brief Parameters for signing a document.
 *
 * The available parameters depend both on the document type and on
 * the signature field for which the SignDocSignatureParameters object
 * has been created.
 *
 * SignDocDocument::addSignature() may fail due to invalid parameters
 * even if all setters reported success as the setters do not check if
 * there are conflicts between parameters.
 *
 * Which certificates are acceptable may be restricted by the
 * application (by using csf_software and csf_hardware of integer
 * parameter "SelectCertificate", blob parameters
 * "FilterCertificatesByIssuerCertificate" and
 * "FilterCertificatesBySubjectCertificate", and string parameters
 * "FilterCertificatesByPolicy" and
 * "FilterCertificatesBySubjectDN") and by the PDF document
 * (certificate seed value dictionary, not yet implemented). If no
 * matching certificate is available (for instance, because integer
 * parameter "SelectCertificate" is zero),
 * SignDocDocument::addSignature() will fail with rc_no_certificate.
 * If more than one matching certificate is available but
 * csf_never_ask is specified in integer parameter
 * "SelectCertificate"), SignDocDocument::addSignature() will fail
 * with rc_ambiguous_certificate.
 *
 * The interaction between some parameters is quite complex; the following
 * section tries to summarize the signing methods for PDF documents.
 * <dl>
 * <dt>(1a)
 * <dd>PKCS #1, private key and self-signed certificate created on the fly:
 *     - Method: m_digsig_pkcs1
 *     - CommonName: signer's name
 *     - GenerateKeyPair: 1024-4096
 *     .
 * <dt>(1b)
 * <dd>PKCS #1, private key provided, self-signed certificate created on
 *     the fly:
 *     - Method: m_digsig_pkcs1
 *     - CommonName: signer's name
 *     - CertificatePrivateKey: private key for self-signed certificate
 *     .
 * <dt>(1c)
 * <dd>PKCS #1, private key provided, self-signed certificate provided:
 *     - Method: m_digsig_pkcs1
 *     - Certificate: self-signed certificate
 *     - CertificatePrivateKey: private key for self-signed certificate
 *     - Signer: Signer's name (not yet extracted from certificate)
 *     .
 * <dt>(2a)
 * <dd>PKCS #7 via SignPKCS7 interface:
 *     - Method: m_digsig_pkcs7_detached or m_digsig_pkcs7_sha1
 *     .
 *     See setPKCS7() for details.
 * <dt>(2b)
 * <dd>PKCS #7, user must select certificate:
 *     - Method: m_digsig_pkcs7_detached or m_digsig_pkcs7_sha1
 *     - DetachedHashAlgorithm: hash algorithm for m_digsig_pkcs7_detached
 *     - SelectCertificate: csf_software and/or csf_hardware
 *     .
 * <dt>(2c)
 * <dd>PKCS #7, user may select certificate or choose to create
 *     a self-signed certificate, the private key of which will be generated:
 *     - Method: m_digsig_pkcs7_detached or m_digsig_pkcs7_sha1
 *     - DetachedHashAlgorithm: hash algorithm for m_digsig_pkcs7_detached
 *     - SelectCertificate: csf_software and/or csf_hardware
 *     - CommonName: signer's name (for self-signed certificate)
 *     - GenerateKeyPair: 1024-4096
 *     .
 *     PKCS #1 will be used if the user chooses to create a self-signed
 *     certificate.
 * <dt>(2d)
 * <dd>PKCS #7, user may select certificate or choose to create
 *     a self-signed certificate, the private key of which is provided:
 *     - Method: m_digsig_pkcs7_detached or m_digsig_pkcs7_sha1
 *     - DetachedHashAlgorithm: hash algorithm for m_digsig_pkcs7_detached
 *     - SelectCertificate: csf_software and/or csf_hardware
 *     - CommonName: signer's name (for self-signed certificate)
 *     - CertificatePrivateKey: private key for self-signed certificate
 *     .
 *     PKCS #1 will be used if the user chooses to create a self-signed
 *     certificate.
 * <dt>(2e)
 * <dd>PKCS #7, user may select certificate or choose to "create"
 *     a self-signed certificate, the certificate and its key are
 *     provided separately:
 *     - Method: m_digsig_pkcs7_detached or m_digsig_pkcs7_sha1
 *     - DetachedHashAlgorithm: hash algorithm for m_digsig_pkcs7_detached
 *     - SelectCertificate: csf_software and/or csf_hardware, csf_create_self_signed
 *     - Certificate: self-signed certificate
 *     - CertificatePrivateKey: private key for self-signed certificate
 *     - Signer: Signer's name (not yet extracted from certificate)
 *     .
 *     PKCS #1 will be used if the user chooses to create a self-signed
 *     certificate.
 * <dt>(2f)
 * <dd>PKCS #7, user may select certificate or choose to "create"
 *     a self-signed certificate, the certificate and its key are
 *     provided as PKCS #12 blob:
 *     - Method: m_digsig_pkcs7_detached or m_digsig_pkcs7_sha1
 *     - DetachedHashAlgorithm: hash algorithm for m_digsig_pkcs7_detached
 *     - SelectCertificate: csf_software and/or csf_hardware, csf_create_self_signed
 *     - Certificate: PKCS #12 blob containing certificate (need not be
 *       self-signed) and its private key
 *     - PKCS #12Password: password for private key in the PKCS #12 blob
 *     .
 * <dt>(2g)
 * <dd>PKCS #7, the certificate and its key are provided as PKCS #12 blob:
 *     - Method: m_digsig_pkcs7_detached or m_digsig_pkcs7_sha1
 *     - DetachedHashAlgorithm: hash algorithm for m_digsig_pkcs7_detached
 *     - Certificate: PKCS #12 blob containing certificate (need not be
 *       self-signed) and its private key
 *     - PKCS #12Password: password for private key in the PKCS #12 blob
 *     .
 * <dt>(2h)
 * <dd>PKCS #7, the certificate is selected programmatically or by the PDF
 *     document without user interaction:
 *     - Method: m_digsig_pkcs7_detached or m_digsig_pkcs7_sha1
 *     - DetachedHashAlgorithm: hash algorithm for m_digsig_pkcs7_detached
 *     - SelectCertificate: csf_software and/or csf_hardware, csf_never_ask
 *     - FilterCertificatesByPolicy: accept certificates having all of these certificate policies
 *     - FilterCertificatesByIssuerCertificate: the acceptable issuer certificates (optional)
 *     - FilterCertificatesBySubjectCertificate: the acceptable certificates (optional)
 *     - FilterCertificatesBySubjectDN: accept certificates issued for these subjects (optional)
 *     .
 * <dt>(2i)
 * <dd>PKCS #7, private key and self-signed certificate created on the fly:
 *     - Method: m_digsig_pkcs7_detached or m_digsig_pkcs7_sha1
 *     - DetachedHashAlgorithm: hash algorithm for m_digsig_pkcs7_detached
 *     - CommonName: signer's name
 *     - GenerateKeyPair: 1024-4096
 *     .
 * <dt>(2j)
 * <dd>PKCS #7, private key provided, self-signed certificate created on
 *     the fly:
 *     - Method: m_digsig_pkcs7_detached or m_digsig_pkcs7_sha1
 *     - DetachedHashAlgorithm: hash algorithm for m_digsig_pkcs7_detached
 *     - CommonName: signer's name
 *     - CertificatePrivateKey: private key for self-signed certificate
 *     .
 * <dt>(2k)
 * <dd>PKCS #7, private key provided, self-signed certificate provided:
 *     - Method: m_digsig_pkcs7_detached or m_digsig_pkcs7_sha1
 *     - DetachedHashAlgorithm: hash algorithm for m_digsig_pkcs7_detached
 *     - Certificate: self-signed certificate
 *     - CertificatePrivateKey: private key for self-signed certificate
 *     - Signer: Signer's name (not yet extracted from certificate)
 *     .
 * </dl>
 *
 * Additionally:
 * - Set integer parameter "Optimize" to o_optimize unless
 *   SignDocDocument::getRequiredSaveToFileFlags()
 *   indicates that SignDocDocument::sf_incremental must be used.
 *   Note that o_optimize requires string parameter "OutputPath" or
 *   "TemporaryDirectory".
 * .
 *
 * For TIFF documents, an additional, simplified signing method is available:
 * <dl>
 * <dt>(3)
 * <dd>just a hash:
 *     - Method: m_hash
 *     - CommonName: signer's name
 *     .
 * </dl>
 */
class SignDocSignatureParameters : private de::softpro::spooc::NonCopyable
{
public:
  /**
   * @brief Signing methods.
   *
   * Used for integer parameter "Method".
   *
   * @see setInteger()
   */
  enum Method
  {
    m_signdoc,                ///< Traditional SignDoc (with data block).
    m_digsig_pkcs1,           ///< PDF DigSig PKCS #1.
    m_digsig_pkcs7_detached,  ///< PDF DigSig detached PKCS #7.
    m_digsig_pkcs7_sha1,      ///< PDF DigSig PKCS #7 with SHA-1.
    m_hash                    ///< The signature is just a hash.
  };

  /**
   * @brief Hash Algorithm to be used for detached signature.
   *
   * Used for integer parameter "DetachedHashAlgorithm".
   *
   * dha_sha256 is supported under Linux, iOS, Android, and under
   * Windows XP SP3 and later.
   * If dha_sha256 is selected but not supported,
   * SignDocDocument::addSignature() will fall back to dha_sha1.
   *
   * @see setInteger()
   */
  enum DetachedHashAlgorithm
  {
    dha_default,               ///< Best supported hash algorithm
    dha_sha1,                  ///< SHA-1
    dha_sha256                 ///< SHA-256
  };

  /**
   * @brief Optimization of document before signing.
   *
   * Used for integer parameter "Optimize".
   *
   * @see setInteger()
   */
  enum Optimize
  {
    o_optimize,               ///< Optimize document before signing for the first time.
    o_dont_optimize           ///< Don't optimize document.
  };

  /**
   * @brief Fix appearance streams of check boxes and radio buttons
   *        for PDF/A documents.
   *
   * Used for integer parameter "PDFAButtons".
   *
   * Using pb_freeze (or pb_auto, if the document claims to be
   * PDF/A-compliant and has no signed signature fields) is equivalent
   * to saving the document with SignDocDocument.sf_pdfa_buttons
   * before signing.
   *
   * @see setInteger()
   */
  enum PDFAButtons
  {
    /**
     * @brief Freeze (fix) appearances.
     */
    pb_freeze,

    /**
     * @brief Don't freeze (fix) appearances.
     */
    pb_dont_freeze,

    /**
     * @brief Freeze (fix) appearances if appropriate.
     *
     * Freeze (fix) appearances if the document claims to be PDF/A-compliant
     * and if there are no signed signature fields.
     */
    pb_auto
  };

  /**
   * @brief Signing algorithms for self-signed certificates.
   *
   * Used for integer parameter "CertificateSigningAlgorithm".
   *
   * @see setInteger()
   */
  enum CertificateSigningAlgorithm
  {
    csa_sha1_rsa,               ///< SHA1 with RSA.
    csa_md5_rsa                 ///< MD5 with RSA.
  };

  /**
   * @brief Select how to encrypt the biometric data.
   *
   * Used for integer parameter "BiometricEncryption".
   * The biometric data to be encrypted is specified by blob parameter
   * "BiometricData".
   *
   * @see setInteger(), setBlob()
   */
  enum BiometricEncryption
  {
    /**
     * @brief Random session key encrypted with public RSA key.
     *
     * Either blob parameter "BiometricKey" (see #setString())
     * or string parameter "BiometricKeyPath" (see #setBlob()) must be set.
     *
     * @see @ref signdocshared_biometric_encryption
     */
    be_rsa,

    /**
     * @brief Fixed key (no security).
     */
    be_fixed,

    /**
     * @brief Binary 256-bit key.
     *
     * Blob parameter "BiometricKey" (see #setBlob()) must be set.
     */
    be_binary,

    /**
     * @brief Passphrase that will be hashed to a  256-bit key.
     *
     * String parameter "BiometricPassphrase" (see #setString()) must be set.
     */
    be_passphrase,

    /**
     * @brief The biometric data won't be stored in the document.
     *
     * Use this value if you want to use the biometric data for
     * generating the signature image only.  Note that using an
     * automatically generated self-signed certificate is secure only
     * if biometric data is stored in the document using asymmetric
     * encryption.
     */
    be_dont_store
  };

  /**
   * @brief Horizontal alignment.
   *
   * Used for integer parameters "ImageHAlignment" and "TextHAlignment"
   * (see #setInteger()).
   */
  enum HAlignment
  {
    ha_left, ha_center, ha_right, ha_justify
  };

  /**
   * @brief Vertical alignment.
   *
   * Used for integer parameters "ImageVAlignment" and "TextVAlignment"
   * (see #setInteger()).
   */
  enum VAlignment
  {
    va_top, va_center, va_bottom
  };

  /**
   * Position of the text block w.r.t. to the image.
   *
   * Used for integer parameter "TextPosition" (see #setInteger()).
   *
   * @todo tp_above, tp_left_of, tp_right_of
   */
  enum TextPosition
  {
    tp_overlay,       ///< Text and image are independent and overlap (text painted on image).
    tp_below,         ///< Text is put below the image, the image is scaled to fit.
    tp_underlay       ///< Text and image are independent and overlap (image painted on text).
  };

  /**
   * @brief Indicate how measurements are specified.
   *
   * @see setLength()
   */
  enum ValueType
  {
    vt_abs,                   ///< @a aValue is the value to be used (units of document coordinates).
    vt_field_height,          ///< Multiply @a aValue by the field height.
    vt_field_width            ///< Multiply @a aValue by the field width.
  };

  /**
   * @brief Select a string for the appearance stream of PDF documents.
   *
   * @see addTextItem(), setString()
   */
  enum TextItem
  {
    ti_signer,                ///< String parameter "Signer"
    ti_sign_time,             ///< String parameter "SignTime"
    ti_comment,               ///< String parameter "Comment"
    ti_adviser                ///< String parameter "Adviser"
  };

  /**
   * @brief Text groups.
   *
   * One font size is used per group and is chosen such that the text
   * fits horizontally.  The maximum font size is specified by
   * length parameter "FontSize".
   * The font size of the slave group cannot be greater
   * than then font size of the master group, that is, long text in
   * the slave group won't reduce the font size of the master group.
   *
   * @see addTextItem(), setLength()
   */
  enum TextGroup
  {
    tg_master,                ///< Master group.
    tg_slave                  ///< Slave group.
  };

  /**
   * @brief Flags for selecting certificates.
   *
   * Used for integer parameter "SelectCertificate".
   *
   * If neither csf_ask_if_ambiguous nor csf_never_ask is included,
   * the certificate selection dialog will be displayed.
   *
   * @see setInteger()
   */
  enum CertificateSelectionFlags
  {
    csf_software = 0x01,        ///< include software-based certificates
    csf_hardware = 0x02,        ///< include hardware-based certificates
    csf_use_certificate_seed_values = 0x10, ///< include only certificates allowed by the PDF document's certificate seed value dictionary
    csf_ask_if_ambiguous = 0x20, ///< ask the user to select a certificate if there is more than one matching certificate
    csf_never_ask = 0x40,       ///< never ask the user to select a certificate; exactly one certificate must match
    csf_create_self_signed = 0x80 ///< offer to create a self-signed certificate (cannot be used with csf_never_ask and csf_ask_if_ambiguous)
  };

  /**
   * @brief Flags for rendering the signature.
   *
   * Used for integer parameter "RenderSignature".
   *
   * rsf_bw, rsf_gray, and rsf_antialias are mutually exclusive.
   *
   * @see setInteger()
   */
  enum RenderSignatureFlags
  {
    rsf_bw   = 0x01,              ///< black and white
    rsf_gray = 0x02,              ///< use gray levels computed from pressure
    rsf_antialias = 0x04          ///< use gray levels for antialiasing
  };

  /**
   * @brief Transparency of signature image.
   *
   * Used for integer parameter "ImageTransparency".
   *
   * If the image has an alpha channel (or if its palette contains a
   * transparent color), the image's transparency will be used no matter
   * what value is set for "ImageTransparency".
   *
   * Transparency is not supported for JPEG images and JPEG-compressed
   * TIFF images.
   * Signature images created from biometric data (according to the
   * "RenderSignature" integer parameter) don't have an alpha channel.
   *
   * @see setInteger()
   */
  enum ImageTransparency
  {
    /** @brief Make signature image opaque.
     *
     * The signature image will be opaque unless the image has an
     * alpha channel or transparent colors in its palette.
     */
    it_opaque,

    /** @brief Make the brightest color transparent.
     *
     * If the image has an alpha channel (or if its palette contains a
     * transparent color), the image's transparency will be used.
     * Otherwise, white will be made transparent for truecolor images
     * and the brightest color in the palette will be made transparent
     * for indexed images (including grayscale images).
     */
    it_brightest
  };

  /**
   * @brief Return codes.
   */
  enum ReturnCode
  {
    rc_ok,                      ///< Parameter set successfully.
    rc_unknown,                 ///< Unknown parameter.
    rc_not_supported,           ///< Setting the parameter is not supported.
    rc_invalid_value            ///< The value for the parameter is invalid.
  };

  /**
   * @brief Status of a parameter.
   *
   * Don't make your code depend on the difference between ps_set and
   * ps_supported.
   *
   * @see getState()
   *
   * @todo implement ps_ignored
   */
  enum ParameterState
  {
    ps_set,             ///< Parameter has been set (most parameters have a default value such as the empty string which may be treated as "set" or "not set" depending on the implementation's fancy)
    ps_missing,         ///< Parameter must be set but is not set.
    ps_supported,       ///< Parameter is supported and optional, but has not been set or is set to the default value
    ps_ignored,         ///< Parameter can be (or is) set but will be ignored
    ps_not_supported,   ///< Parameter is not supported for this field.
    ps_unknown          ///< Unknown parameter.
  };

public:
  /**
   * @brief Constructor.
   *
   * Use SignDocDocument::createSignatureParameters() instead.
   */
  SignDocSignatureParameters () { }

  /**
   * @brief Destructor.
   *
   * Overwrites this object's copies of the private key and biometric
   * data.
   */
  virtual ~SignDocSignatureParameters () { }

  /**
   * @brief Get the status of a parameter.
   *
   * @param[in] aName   The name of the parameter (case-sensitive).
   *
   * @return see enum #ParameterState.
   */
  virtual ParameterState getState (const std::string &aName) = 0;

  /**
   * @brief Set a string parameter.
   *
   * Available string parameters are:
   * - @b Adviser          The adviser.
   *                       For DigSig signature fields, the adviser may be used
   *                       for the appearance stream of PDF documents.
   *                       The default value is empty.
   *                       Complex scripts are supported,
   *                       see @ref signdocshared_complex_scripts.
   * - @b BiometricKeyPath   The pathname of a file containing the public key
   *                       in PKCS #1 or X.509 format for encrypting the
   *                       biometric data
   *                       with integer parameter "BiometricEncryption" set
   *                       to be_rsa. See also blob parameter "BiometricKey"
   *                       and @ref signdocshared_biometric_encryption.
   * - @b BiometricPassphrase  Passphrase to be used if integer parameter
   *                       "BiometricEncryption" is be_passphrase.
   *                       Should contain ASCII characters only.
   * - @b Comment          The comment.
   *                       For DigSig signature fields, the comment may be used
   *                       for the appearance stream of PDF documents.  The
   *                       comment can contain multiple lines which are
   *                       separated by '\n'. The default value is empty.
   *                       Complex scripts are supported,
   *                       see @ref signdocshared_complex_scripts.
   * - @b CommonName       The common name for the self-signed certificate.
   *                       When a self-signed certificate is to be generated,
   *                       the common name (CN) must be set.
   *                       See also string parameter "Signer".
   * - @b ContactInfo      The contact information provided by the signer.
   *                       For DigSig signature fields, the contact
   *                       information will be stored in the digital
   *                       signature.  The default value is empty.
   * - @b Country          The country name for the self-signed certificate.
   *                       When a self-signed certificate is to be generated,
   *                       the country name (C) should be set. Use ISO 3166
   *                       country codes.
   *                       The default value is empty.
   * - @b Filter           The name of the preferred filter.
   *                       For DigSig signature fields, the filter
   *                       name will be stored in the digital
   *                       signature.  The default value is "SOFTPRO
   *                       DigSig Security".
   *                       You might want to set the filter to "Adobe.PPKLite".
   * - @b FilterCertificatesByPolicy  A required certificate policy.
   *                       Setting this parameter adds the specified OID
   *                       to a list of required policy object identifiers.
   *                       All specified policies are required for a
   *                       certificate to be accepted.
   *                       Pass an empty value to clear the list.
   *                       The value must be a valid ASN.1 object identifier.
   *                       A PDF document may contain (in its certificate seed
   *                       value dictionaries) additional restrictions
   *                       for acceptable certificates.
   *                       SignDocDocument::addSignature() will fail if no
   *                       matching certificate is available for signing.
   *                       Note that csf_software and/or csf_hardware must
   *                       be included in integer parameter "SelectCertificate"
   *                       to make certificates available at all.
   * - @b FilterCertificatesBySubjectDN  An acceptable subject Distinguished
   *                       Name (DN).
   *                       Setting this parameter adds the specified
   *                       DN to a list of acceptable DNs.
   *                       Pass an empty value to clear the list.
   *                       The DN must be formatted according to RFC 4514,
   *                       using short names for the attribute types.
   *                       Multi-valued RDNs and multiple RDNs specifying
   *                       a value for the same attribute are not allowed.
   *                       A PDF document may contain (in its certificate seed
   *                       value dictionaries) additional restrictions
   *                       for acceptable certificates.
   *                       SignDocDocument::addSignature() will fail if no
   *                       matching certificate is available for signing.
   *                       Note that csf_software and/or csf_hardware must
   *                       be included in integer parameter "SelectCertificate"
   *                       to make certificates available at all.
   * - @b Locality         The location name for the self-signed certificate.
   *                       When a self-signed certificate is to be generated,
   *                       the location name (L) should be set.
   *                       The default value is empty.
   *                       Do not confuse "Locality" and "Location"!
   * - @b Location         The host name or physical location of signing.
   *                       For DigSig signature fields, the location
   *                       will be stored in the digital signature.
   *                       The default value is empty.
   *                       Do not confuse "Location" and "Locality"!
   * - @b Organization     The organization name for the self-signed
   *                       certificate.
   *                       When a self-signed certificate is to be generated,
   *                       the organization name (O) should be set.
   *                       The default value is empty.
   * - @b OrganizationUnit  The organization unit name for the self-signed
   *                       certificate.
   *                       When a self-signed certificate is to be generated,
   *                       the organization unit name (OU) should be set.
   *                       The default value is empty.
   * - @b OutputPath       Some signing methods need to write to a file. This
   *                       parameter contains the output pathname. If this
   *                       parameter is non-empty, string parameter
   *                       "TemporaryDirectory" will be ignored. See also
   *                       integer parameter "Optimize".
   *                       The default value is empty.
   * - @b PKCS#12Password   The password for extracting the private key from
   *                       the PKCS #12 blob set as blob parameter
   *                       "Certificate". The password must contain ASCII
   *                       characters only.
   * - @b Reason           The reason for the signing.
   *                       For DigSig signature fields, the reason
   *                       will be stored in the digital signature.
   *                       The default value is empty.
   * - @b Signer           The signer name.
   *                       This is the signer name that will be stored in the
   *                       digital signature. If not set, the name will be
   *                       taken from the certificate.
   *                       For DigSig signature fields, the signer name may be
   *                       used for the appearance stream of PDF documents.
   *                       The default value is empty (meaning that the name
   *                       will be taken from the certificate).
   *                       See also string parameter "CommonName".
   *                       Complex scripts are supported,
   *                       see @ref signdocshared_complex_scripts.
   * - @b SignTime         The time of signing in free format.
   *                       For DigSig signature fields, the time of
   *                       signing may be used for the appearance
   *                       stream of PDF documents.
   *                       The default value is empty.
   *                       See also string parameter "Timestamp".
   * - @b TemporaryDirectory  Some signing methods need to write to a file.
   *                       This parameter specifies the directory to be used
   *                       for temporary files.  If empty (default), the system
   *                       default will be used. If "OutputPath" is set,
   *                       "TemporaryDirectory" will be ignored. See also
   *                       integer parameter "Optimize".
   * - @b Timestamp        The timestamp to be used in the digital signature
   *                       (instead of the current time).
   *                       ISO 8601 format must be used: "yyyy-mm-ddThh:mm:ss"
   *                       with optional timezone.
   *                       For DigSig signature fields, the timestamp
   *                       will be stored in the signature dictionary
   *                       (transformed suitably for the M entry).
   *                       If empty, the current time will be used.
   *                       The default value is empty.
   *                       If this parameter is set to a non-empty value,
   *                       no time stamp will be retrieved from an RFC 3161
   *                       time-stamp server, even if specified by the
   *                       signature field seed value dictionary.
   *                       Do not set this parameter if a self-signed
   *                       certificate is to be created.
   *                       See also string parameters "SignTime" and
   *                       "TimeStampServerURL".
   * - @b TimeStampClientCertificatePath  The pathname of a file containing
   *                       the certificate in PEM format for
   *                       authenticating to an RFC 3161 time-stamp server
   *                       over HTTPS.  If the is non-empty,
   *                       string parameter "TimeStampClientKeyPath"
   *                       must also be set.
   *                       If the value is empty, the client won't
   *                       authenticate itself.
   *                       The default value is empty.
   *                       See also string parameters "TimeStampServerURL",
   *                       "TimeStampClientKeyPath",
   *                       and "TimeStampServerTrustedCertificatesPath".
   * - @b TimeStampClientKeyPath  The pathname of a file containing
   *                       the private key in PEM format for
   *                       authenticating to an RFC 3161 time-stamp server
   *                       over HTTPS.  If the is non-empty,
   *                       string parameter "TimeStampClientCertificatePath"
   *                       must also be set.
   *                       If the value is empty, the client won't
   *                       authenticate itself.
   *                       The default value is empty.
   *                       See also string parameters "TimeStampServerURL",
   *                       "TimeStampClientKeyPath",
   *                       and "TimeStampServerTrustedCertificatesPath".
   * - @b TimeStampServerPassword  The password for Basic/Digest HTTP
   *                       authentication to the time-stamp server.
   *                       Non-ASCII values probably don't work.
   *                       If this parameter is set, string parameter
   *                       "TimeStampServerUser" must also be set.
   * - @b TimeStampServerTrustedCertificatesPath  The pathname of a file containing
   *                       trusted root certificates in PEM format for
   *                       authenticating RFC 3161 time-stamp servers
   *                       over HTTPS.
   *                       If the value is empty, time-stamp servers
   *                       won't be authenticated.
   *                       The default value is empty.
   *                       See also string parameters "TimeStampServerURL",
   *                       "TimeStampClientCertificatePath",
   *                       and "TimeStampClientKeyPath".
   * - @b TimeStampServerURL  The URL of an RFC 3161 time-stamp server.
   *                       If string parameter "Timestamp" is empty
   *                       and string parameter "TimeStampServerURL" is
   *                       non-empty, a time stamp will be obtained from
   *                       a time-stamp server. The scheme of the URL must
   *                       be either "http" or "https".
   *                       The time-stamp server URL specified by the
   *                       document's signature field seed value dictionary
   *                       overrides the "TimeStampServerURL" parameter.
   *                       An error will be
   *                       returned by SignDocDocument::addSignature() if
   *                       a time-stamp server is to be used and integer
   *                       parameter "Method" is not m_digsig_pkcs7_detached
   *                       or m_digsig_pkcs7_sha1.
   *                       See also integer parameter
   *                       "TimeStampServerTimeout" and string parameters
   *                       "TimeStampClientCertificatePath",
   *                       "TimeStampClientKeyPath",
   *                       "TimeStampServerPassword",
   *                       "TimeStampServerTrustedCertificatesPath", and
   *                       "TimeStampServerUser".
   * - @b TimeStampServerUser  The user name for Basic/Digest HTTP
   *                       authentication to the time-stamp server.
   *                       Non-ASCII values probably don't work.
   *                       If this parameter is set, string parameter
   *                       "TimeStampServerPassword" must also be set.
   * .
   *
   * @param[in] aEncoding  The encoding used for @a aValue.
   * @param[in] aName   The name of the parameter (case-sensitive).
   * @param[in] aValue  The value of the parameter. The encoding is specified
   *                    by @a aEncoding.
   *   
   *
   * @return rc_ok if successful.
   */
  virtual ReturnCode setString (de::softpro::doc::Encoding aEncoding,
                                const std::string &aName,
                                const std::string &aValue) = 0;

  /**
   * @brief Set a string parameter.
   *
   * See the other setString() function for a list of available
   * string parameters.
   *
   * @param[in] aName   The name of the parameter (case-sensitive).
   * @param[in] aValue  The value of the parameter.
   *
   * @return rc_ok if successful.
   */
  virtual ReturnCode setString (const std::string &aName,
                                const wchar_t *aValue) = 0;

  /**
   * @brief Set an integer parameter.
   *
   * Available integer parameters are:
   * - @b %BiometricEncryption   Specifies how biometric data is to be
   *                       encrypted (enum #BiometricEncryption).
   *                       If not set, biometric data will not be embedded
   *                       in the signature.
   * - @b %CertificateSigningAlgorithm  The signing algorithm for the self-signed
   *                       certificate (enum #CertificateSigningAlgorithm).
   *                       When a self-signed certificate is to be generated,
   *                       the signing algorithm can be set. If not set, a
   *                       suitable default value will be used.
   * - @b %DetachedHashAlgorithm  Hash algorithm to be used for detached signature
   *                       (ie, if integer parameter "Method" is
   *                       m_digsig_pkcs7_detached).
   *                       See enum #DetachedHashAlgorithm.
   *                       The default value is dha_default.
   * - @b GenerateKeyPair  Start generation of a key pair for the self-signed
   *                       certificate.  The value is the number of bits
   *                       (1024 through 4096, multiple of 8).
   *                       When a self-signed certificate is to be generated,
   *                       the private key can be either be generated by
   *                       setting this parameter or set as blob parameter
   *                       "CertificatePrivateKey".
   * - @b ImageHAlignment  The horizontal alignment of the image
   *                       (enum #HAlignment).
   *                       For DigSig signature fields, this parameter
   *                       defines the horizontal alignment of the image
   *                       in the appearance stream of PDF documents.
   *                       The default value depends on the profile
   *                       passed to
   *                       SignDocDocument::createSignatureParameters().
   * - @b ImageVAlignment  The vertical alignment of the image
   *                       (enum #VAlignment).
   *                       For DigSig signature fields, this parameter
   *                       defines the vertical alignment of the image
   *                       in the appearance stream of PDF documents.
   *                       The default value depends on the profile
   *                       passed to
   *                       SignDocDocument::createSignatureParameters().
   * - @b ImageTransparency  Image transparency (enum #ImageTransparency).
   *                       For DigSig signature fields, this parameter
   *                       defines how to handle transparency for signature
   *                       image (either the image passed in the "Image"
   *                       blob parameter or the image computed according
   *                       to the "RenderSignature" integer parameter).
   *                       The default value is it_brightest.
   * - @b %Method          The signing method (enum #Method).
   *                       If no signing method is set, a suitable
   *                       default method will be used.
   * - @b %Optimize        Set whether this is the first signature of the
   *                       document and the document shall be optimized or
   *                       whether the document shall not be optimized.
   *                       Use one of the values of enum #Optimize.
   *                       For PDF documents, o_optimize requires saving to
   *                       a new file, see string parameters
   *                       "OutputPath" and "TemporaryDirectory".
   *                       The default value is o_dont_optimize.
   *                       If the return value of getRequiredSaveToFileFlags()
   *                       includes sf_incremental, signing with this parameter
   *                       set to o_optimize will break existing signatures.
   * - @b %PDFAButtons     Set whether appearance streams of check boxes
   *                       and radio buttons shall be frozen (fixed) for
   *                       PDF/A compliance before signing.
   *                       Use one of the values of enum #PDFAButtons.
   *                       The default value is pb_auto.
   * - @b PenWidth         Pen width for rendering the signature (see blob
   *                       parameter "BiometricData") for the signature image.
   *                       Ignored unless integer parameter "RenderSignature"
   *                       is non-zero.
   *                       The pen width is specified in micrometers, the
   *                       default value is 500 (0.5mm).
   * - @b RenderSignature  Specifies whether and how the signature (see blob
   *                       parameter "BiometricData") is to be
   *                       rendered for the signature image.  This parameter
   *                       contains a set of flags taken from
   *                       enum #RenderSignatureFlags.
   *                       If this value is 0, the signature won't be rendered.
   *                       SignWare is required for rendering signatures.
   *                       If no image is rendered (or set, see blob parameter
   *                       "Image"), the signature field may or
   *                       may not show an image computed from the
   *                       biometric data, depending on the document
   *                       type and signature field type.
   *                       This parameter is ignored if blob parameter
   *                       "Image" is set.
   *                       The default value is 0.  See also integer parameters
   *                       "ImageTransparency", "PenWidth", and "RenderWidth"
   *                       and color parameter "SignatureColor".
   *                       "RenderSignature" is not supported under iOS
   *                       and Android.
   * - @b RenderWidth      Specifies the width (in pixels) for the signature
   *                       image rendered from biometric data for PDF
   *                       documents. This parameter is ignored for TIFF
   *                       documents. The default value is 600.
   * - @b SelectCertificate   Let the user and/or the application select
   *                       the certificate for the signature.
   *                       The parameter contains a set of flags taken from
   *                       enum #CertificateSelectionFlags.
   *                       If this parameter is zero (which is the default
   *                       value), the user won't be asked and the certificate
   *                       will either be generated on the fly or be supplied
   *                       by the "Certificate" blob parameter and
   *                       SignDocDocument::addSignature() will fail if the
   *                       PDF document restricts acceptable certificates by
   *                       means of a certificate seed value dictionary.
   *                       This parameter is not yet implemented under Linux,
   *                       iOS, and Android.
   * - @b TextHAlignment   The horizontal alignment of text lines
   *                       (enum #HAlignment).
   *                       For DigSig signature fields, this parameter
   *                       defines the horizontal alignment of text lines
   *                       in the appearance stream of PDF documents.
   *                       The default value depends on the profile
   *                       passed to
   *                       SignDocDocument::createSignatureParameters().
   * - @b %TextPosition    The position of the text block w.r.t. the image
   *                       (enum #TextPosition).
   *                       For DigSig signature fields, this parameter
   *                       defines the position of the text block in the
   *                       appearance stream of PDF documents.  The
   *                       default value depends on the profile passed
   *                       to SignDocDocument::createSignatureParameters().
   * - @b TextVAlignment   The vertical alignment of text lines
   *                       (enum #VAlignment).
   *                       For DigSig signature fields, this parameter
   *                       defines the vertical alignment of text lines
   *                       in the appearance stream of PDF documents.
   *                       The default value depends on the profile
   *                       passed to
   *                       SignDocDocument::createSignatureParameters().
   * - @b TimeStampServerTimeout  Time out in milliseconds for retrieving
   *                       a time stamp from an RFC 3161 time-stamp server.
   *                       The value must be positive. The default value
   *                       is 10000.
   *                       See also string parameter "TimeStampServerURL".
   * .
   *
   * @param[in] aName   The name of the parameter (case-sensitive).
   * @param[in] aValue  The value of the parameter.
   *
   * @return rc_ok if successful.
   *
   * @todo document when "SelectCertificate" presents the dialog
   * @todo implement "SelectCertificate" for Linux
   */
  virtual ReturnCode setInteger (const std::string &aName,
                                 int aValue) = 0;

  /**
   * @brief Set a blob parameter.
   *
   * Available blob parameters are:
   * - @b BiometricData    The biometric data must either be in
   *                       SignDoc format (created by the Serialize()
   *                       function of SDSIGNATUREMANAGER) or in
   *                       SignWare format (created by
   *                       SPFlatFileCreateFromSignature()).
   *                       The biometric data is stored in the document
   *                       (see integer parameter "BiometricEncryption")
   *                       and will be used for rendering the signature image
   *                       if integer parameter "RenderSignature" is non-zero
   *                       (unless a signature image is specified by blob
   *                       parameter "Image").
   * - @b BiometricKey     The public key (be_rsa) or the AES key (be_binary)
   *                       for encrypting the biometric data. See also
   *                       string parameter "BiometricKeyPath" and
   *                       @ref signdocshared_biometric_encryption.
   * - @b Certificate      The certificate for the signature.
   *                       The blob must contain
   *                       a serialized X.509 certificate (DER format) and
   *                       blob parameter "CertificatePrivateKey" must contain
   *                       the private key for that certificate.
   *                       Alternatively, for PKCS #7 signatures, the blob
   *                       may contain the
   *                       certificate and its private key in PKCS #12 format;
   *                       string parameter "PKCS#12Password" contains the
   *                       password for extracting the private key.
   * - @b CertificatePrivateKey  The private key for the (self-signed) certificate
   *                       in PKCS #1 format.
   *                       If a certificate is passed
   *                       in blob parameter "Certificate", this parameter
   *                       must contain the private key for that certificate.
   *                       If a self-signed certificate is to be generated,
   *                       the private key can be either set with this parameter
   *                       or generated with integer parameter
   *                       "GenerateKeyPair".
   * - @b FilterCertificatesByIssuerCertificate   Acceptable issuer certificates.
   *                       Setting this parameter adds the specified
   *                       DER-encoded certificate to a list of acceptable
   *                       issuer certificates.
   *                       Pass 0 for @a aSize to clear the list.
   *                       A PDF document may contain (in its certificate seed
   *                       value dictionaries) additional restrictions
   *                       for acceptable issuer certificates.
   *                       A signer certificate is acceptable for the rule
   *                       defined by this parameter if it chains up to any
   *                       of the certificates in the list of acceptable
   *                       issuer certificates.
   *                       SignDocDocument::addSignature() will fail if no
   *                       matching certificate is available for signing.
   *                       Note that csf_software and/or csf_hardware must
   *                       be included in integer parameter "SelectCertificate"
   *                       to make certificates available at all.
   * - @b FilterCertificatesBySubjectCertificate   Acceptable certificates.
   *                       Setting this parameter adds the specified
   *                       DER-encoded certificate to a list of acceptable
   *                       certificates.
   *                       Pass 0 for @a aSize to clear the list.
   *                       A PDF document may contain (in its certificate seed
   *                       value dictionaries) additional restrictions
   *                       for acceptable certificates.
   *                       SignDocDocument::addSignature() will fail if no
   *                       matching certificate is available for signing.
   *                       Note that csf_software and/or csf_hardware must
   *                       be included in integer parameter "SelectCertificate"
   *                       to make certificates available at all.
   * - @b Image            The signature image.
   *                       The image can be in BMP, JPEG, PNG, or TIFF format.
   *                       If no image is set (or rendered, see integer
   *                       parameter "RenderSignature"), the signature field
   *                       may or may not show an image computed from the
   *                       biometric data, depending on the document
   *                       type and signature field type.
   *                       This parameter overrides integer parameter
   *                       "RenderSignature".
   *                       See also integer parameter "ImageTransparency".
   * .
   *
   * @param[in] aName   The name of the parameter (case-sensitive).
   * @param[in] aData   A pointer to the first octet of the value.
   * @param[in] aSize   Size of the blob (number of octets).
   *
   * @return rc_ok if successful.
   *
   * @todo support PKCS #7 for "Certificate"
   */
  virtual ReturnCode setBlob (const std::string &aName,
                              const unsigned char *aData, size_t aSize) = 0;

  /**
   * @brief Set a length parameter.
   *
   * Available length parameters are:
   * - @b FontSize         The maximum font size.
   *                       For DigSig signature fields, this parameter
   *                       defines the maximum font size for the
   *                       appearance stream of PDF documents.  The
   *                       font size will be reduced to make all text
   *                       lines fit horizontally into the signature
   *                       field.  The default value depends on the
   *                       profile passed to
   *                       SignDocDocument::createSignatureParameters().
   * - @b ImageMargin      The margin to add around the image.
   *                       For DigSig signature fields, this parameter
   *                       defines the margin to be added around the
   *                       image in the appearance stream of PDF
   *                       documents.  This margin is added at all
   *                       four edges of the image.  The default value
   *                       depends on the profile passed to
   *                       SignDocDocument::createSignatureParameters().
   * - @b TextHMargin      The horizontal margin for text.
   *                       For DigSig signature fields, this parameter
   *                       defines the horizontal margin of text in the
   *                       appearance stream of PDF documents.  If the
   *                       text is centered or justified, @a aValue/2
   *                       will be used for the two margins.  The
   *                       default value depends on the profile passed
   *                       to
   *                       SignDocDocument::createSignatureParameters().
   * .
   *
   * @param[in] aName   The name of the parameter (case-sensitive).
   * @param[in] aType   Define how the length is specified.
   * @param[in] aValue  The value of the parameter.
   *
   * @return rc_ok if successful.
   */
  virtual ReturnCode setLength (const std::string &aName,
                                ValueType aType,
                                double aValue) = 0;

  /**
   * @brief Set a color parameter.
   *
   * Available color parameters are:
   * - @b SignatureColor   The foreground color for the rendered signature
   *                       (see integer parameter "RenderSignature").
   *                       The default color is black.
   * .
   * @param[in] aName   The name of the parameter (case-sensitive).
   * @param[in] aValue  The value of the parameter.
   *
   * @return rc_ok if successful.
   */
  virtual ReturnCode setColor (const std::string &aName,
                               const SignDocColor &aValue) = 0;

  /**
   * @brief Add another string to be displayed, top down.
   *
   * For DigSig signature fields, this function adds another string to
   * the appearance stream of PDF documents.
   * The first call clears any default strings.
   * The default values depend on the profile passed to
   * SignDocDocument::createSignatureParameters().
   *
   * @param[in] aItem   Select the string to be added.
   * @param[in] aGroup  The string's group for font size computation.
   *
   * @return rc_ok if successful.
   */
  virtual ReturnCode addTextItem (TextItem aItem, TextGroup aGroup) = 0;

  /**
   * @brief Set an object which will create a PKCS #7 signature.
   *
   * By default, PKCS #7 signatures are handled internally which means
   * that the private key must be available on this machine.
   *
   * Requirements for string parameters:
   * - CommonName         must not be set
   * - Country            must not be set
   * - Locality           must not be set
   * - Organization       must not be set
   * - OrganizationUnit   must not be set
   * .
   *
   * Requirements for integer parameters:
   * - GenerateKeyPair    must not be set
   * - Method             must be m_digsig_pkcs7_detached
   *                      or m_digsig_pkcs7_sha1
   * - SelectCertificate  must be zero (which is the default value)
   * .
   *
   * Requirements for blob parameters:
   * - Certificate        must not be set
   * - CertificatePrivateKey   must not be set
   * .
   *
   * @param[in] aPKCS7  The object that will create the PKCS #7 signature.
   *                    This function does not take ownership of that object.
   *
   * @return rc_ok if successful.
   */
  virtual ReturnCode setPKCS7 (SignPKCS7 *aPKCS7) = 0;

  /**
   * @brief Get a bitset indicating which signing methods are available
   *        for this signature field.
   *
   * @return 1<<m_signdoc etc.
   *
   * @see SignDocDocument::getAvailableMethods()
   */
  virtual int getAvailableMethods () = 0;

  /**
   * @brief Get an error message for the last function call.
   *
   * @param[in] aEncoding  The encoding to be used for the error message.
   *
   * @return A pointer to a string describing the reason for the
   *         failure of the last function call. The string is empty
   *         if the last call succeeded. The pointer is valid until
   *         this object is destroyed or a member function of this
   *         object is called.
   *
   * @see getErrorMessageW()
   */
  virtual const char *getErrorMessage (de::softpro::doc::Encoding aEncoding) const = 0;

  /**
   * @brief Get an error message for the last function call.
   *
   * @return A pointer to a string describing the reason for the
   *         failure of the last function call. The string is empty
   *         if the last call succeeded. The pointer is valid until
   *         this object is destroyed or a member function of this
   *         object is called.
   *
   * @see getErrorMessage()
   */
  virtual const wchar_t *getErrorMessageW () const = 0;
};

/**
 * @brief One property, without value.
 *
 * Use SignDocDocument::getBooleanProperty(),
 * SignDocDocument::getIntegerProperty(), or
 * SignDocDocument::getStringProperty() to get the value of a
 * property.
 */
class SPSDEXPORT1 SignDocProperty
{
public:
  class Impl;

public:
  /**
   * @brief Property types.
   */
  enum Type
  {
    t_string,
    t_integer,
    t_boolean
  };

public:
  /**
   * @brief Constructor.
   */
  SignDocProperty ();

  /**
   * @brief Copy constructor.
   *
   * @param[in] aSource  The object to be copied.
   */
  SignDocProperty (const SignDocProperty &aSource);

  /**
   * @brief Destructor.
   */
  ~SignDocProperty ();

  /**
   * @brief Assignment operator.
   *
   * @param[in] aSource  The source object.
   */
  SignDocProperty &operator= (const SignDocProperty &aSource);

  /**
   * @brief Efficiently swap this object with another one.
   *
   * @param[in] aOther  The other object.
   */
  void swap (SignDocProperty &aOther);

  /**
   * @brief Get the name of the property.
   *
   * Property names are compared under Unicode simple case folding, that is,
   * lower case and upper case is not distinguished.
   *
   * This function throws de::softpro::spooc::EncodingError if
   * the name cannot be represented using the specified encoding.
   *
   * @param[in] aEncoding  The encoding to be used for the return value.
   *
   * @return The name of the property.
   *
   * @see getNameUTF8(), setName()
   */
  std::string getName (de::softpro::doc::Encoding aEncoding) const;

  /**
   * @brief Get the name of the property as UTF-8-encoded C string.
   *
   * Property names are compared under Unicode simple case folding, that is,
   * lower case and upper case is not distinguished.
   *
   * @return The name of the property.  This pointer will become invalid
   *         when setName() is called or this object is destroyed.
   *
   * @see getName(), setName()
   */
  const char *getNameUTF8 () const;

  /**
   * @brief Set the name of the property.
   *
   * Property names are compared under Unicode simple case folding, that is,
   * lower case and upper case is not distinguished.  The encoding is specified
   * by @a aEncoding of #SignDocDocument::getProperties().
   *
   * This function throws de::softpro::spooc::EncodingError if the
   * value is not correctly encoded according to the specified
   * encoding.
   *
   * @param[in] aEncoding  The encoding of @a aName.
   * @param[in] aName      The name of the property.
   *
   * @see getName(), getNameUTF8()
   */
  void setName (de::softpro::doc::Encoding aEncoding, const std::string &aName);

  /**
   * @brief Get the type of the property.
   *
   * @return The type of the property.
   *
   * @see setType()
   */
  Type getType () const;

  /**
   * @brief Set the type of the property.
   *
   * @param[in] aType  The type of the property.
   *
   * @see getType()
   */
  void setType (Type aType);

  /**
   * @brief Internal use only.
   * @internal
   */
  Impl *getImpl ();

  /**
   * @brief Internal use only.
   * @internal
   */
  const Impl *getImpl () const;

private:
  Impl *p;
};

/**
 * @brief An annotation.
 *
 * Currently, annotations are supported for PDF documents only.
 *
 * @see createLineAnnotation(), createScribbleAnnotation(), createFreeTextAnnotation(), getAnnotation()
 */
class SignDocAnnotation
{
public:
  /**
   * @brief Annotation types.
   *
   * Most annotation types are supported for PDF documents only.
   */
  enum Type
  {
    t_unknown,              ///< Unknown annotation type.
    t_line,                 ///< Line annotation.
    t_scribble,             ///< Scribble annotation (freehand scribble).
    t_freetext              ///< FreeText annotation.
  };

  /**
   * @brief Line ending styles.
   */
  enum LineEnding
  {
    le_unknown,             ///< Unknown line ending style.
    le_none,                ///< No line ending.
    le_arrow                ///< Two short lines forming an arrowhead.
  };

  /**
   * @brief Horizontal alignment.
   */
  enum HAlignment
  {
    ha_left, ha_center, ha_right
  };

  /**
   * @brief Return codes.
   */
  enum ReturnCode
  {
    rc_ok,                      ///< Parameter set successfully.
    rc_not_supported,           ///< Setting the parameter is not supported.
    rc_invalid_value,           ///< The value for the parameter is invalid.
    rc_not_available            ///< The value is not available.
  };

protected:
  /**
   * @brief Constructor.
   */
  SignDocAnnotation () { }

public:
  /**
   * @brief Destructor.
   */
  virtual ~SignDocAnnotation () { }

  /**
   * @brief Get the type of the annotation.
   */
  virtual Type getType () const = 0;

  /**
   * @brief Get the name of the annotation.
   *
   * @param[in]  aEncoding  The encoding to be used for the return value.
   *
   * @return The name of the annotation or an empty string if the name is
   *         not available.
   */
  virtual std::string getName (de::softpro::doc::Encoding aEncoding) const = 0;

  /**
   * @brief Get the page number of the annotation.
   *
   * The page number is available for objects returned by
   * SignDocDocument::getAnnotation() only.
   *
   * @return the 1-based page number of the annotation or 0 if the page
   *         number is not available.
   */
  virtual int getPage () const = 0;

  /**
   * @brief Get the bounding box of the annotation.
   *
   * The bounding box is available for objects returned by
   * getAnnotation() only.
   *
   * @param[out] aOutput  The bounding box (using document coordinates, see
   *          @ref signdocshared_coordinates) will be stored here.
   *
   * @return rc_ok if successful.
   */
  virtual ReturnCode getBoundingBox (de::softpro::doc::Rect &aOutput) const = 0;

  /**
   * @brief Set the name of the annotation.
   *
   * In PDF documents, an annotation can have a name.  The names of
   * annotations must be unique within a page.  By default, annotations
   * are unnamed.
   *
   * @param[in] aEncoding  The encoding of @a aName.
   * @param[in] aName  The name of the annotation.
   *
   * @return rc_ok if successful.
   */
  virtual ReturnCode setName (de::softpro::doc::Encoding aEncoding,
                              const std::string &aName) = 0;

  /**
   * @brief Set the name of the annotation.
   *
   * In PDF documents, an annotation can have a name.  The names of
   * annotations must be unique within a page.  By default, annotations
   * are unnamed.
   *
   * @param[in] aName  The name of the annotation.
   *
   * @return rc_ok if successful.
   */
  virtual ReturnCode setName (const wchar_t *aName) = 0;

  /**
   * @brief Set line ending styles.
   *
   * This function can be used for annotations of type t_line.
   * The default line ending style is le_none.
   *
   * @param[in] aStart  Line ending style for start point.
   * @param[in] aEnd    Line ending style for end point.
   *
   * @return rc_ok if successful.
   */
  virtual ReturnCode setLineEnding (LineEnding aStart, LineEnding aEnd) = 0;

  /**
   * @brief Set the foreground color of the annotation.
   *
   * This function can be used for annotations of types t_line, t_scribble,
   * and t_freetext.
   *
   * The default foreground color is black.
   *
   * @param[in] aColor  The foreground color of the annotation.
   *
   * @return rc_ok if successful.
   */
  virtual ReturnCode setColor (const SignDocColor &aColor) = 0;

  /**
   * @brief Set the background color of the annotation.
   *
   * This function can be used for annotations of type t_freetext.
   *
   * The default background color is white.
   *
   * @param[in] aColor  The background color of the annotation.
   *
   * @return rc_ok if successful.
   */
  virtual ReturnCode setBackgroundColor (const SignDocColor &aColor) = 0;

  /**
   * @brief Set the border color of the annotation.
   *
   * This function can be used for annotations of type t_freetext.
   *
   * The default border color is black.
   *
   * @param[in] aColor  The border color of the annotation.
   *
   * @return rc_ok if successful.
   *
   * @see setBorderLineWidthInPoints()
   */
  virtual ReturnCode setBorderColor (const SignDocColor &aColor) = 0;

  /**
   * @brief Set the opacity of the annotation.
   *
   * This function can be used for annotations of types t_line, t_scribble,
   * and t_freetext.
   *
   * The default opacity is 1.0. Documents conforming to PDF/A must
   * use an opacity of 1.0.
   *
   * @param[in] aOpacity  The opacity, 0.0 (transparent) through 1.0 (opaque).
   *
   * @return rc_ok if successful.
   */
  virtual ReturnCode setOpacity (double aOpacity) = 0;

  /**
   * @brief Set line width in points.
   *
   * This function can be used for annotations of types t_line and t_scribble.
   * The default line width for PDF documents is 1 point.
   *
   * @param[in] aWidth  The line width in points (1/72 inch).
   *
   * @return rc_ok if successful.
   */
  virtual ReturnCode setLineWidthInPoints (double aWidth) = 0;

  /**
   * @brief Set border line width in points.
   *
   * This function can be used for annotations of type t_freetext.
   * The default border line width for PDF documents is 1 point.
   *
   * @param[in] aWidth  The border line width in points (1/72 inch).  If this
   *                    value is negative, no border lines will be drawn.
   *
   * @return rc_ok if successful.
   *
   * @see setBorderColor()
   */
  virtual ReturnCode setBorderLineWidthInPoints (double aWidth) = 0;

  /**
   * @brief Start a new stroke in a scribble annotation.
   *
   * This function can be used for annotations of type t_scribble.
   * Each stroke must contain at least two points.  This function need
   * not be called for the first stroke of a scribble annotation.
   *
   * @return rc_ok if successful.
   *
   * @see addPoint()
   */
  virtual ReturnCode newStroke () = 0;

  /**
   * @brief Add a point to the current stroke of a scribble annotation.
   *
   * This function can be used for annotations of type t_scribble.
   * Each stroke must contain at least two points.
   * This function uses document (page) coordinates,
   * see @ref signdocshared_coordinates.
   *
   * @param[in] aPoint  The point to be added.
   *
   * @return rc_ok if successful.
   *
   * @see newStroke()
   */
  virtual ReturnCode addPoint (const de::softpro::doc::Point &aPoint) = 0;

  /**
   * @brief Add a point to the current stroke of a scribble annotation.
   *
   * This function can be used for annotations of type t_scribble.
   * Each stroke must contain at least two points.
   * This function uses document (page) coordinates,
   * see @ref signdocshared_coordinates.
   *
   * @param[in] aX  The X coordinate of the point.
   * @param[in] aY  The Y coordinate of the point.
   *
   * @return rc_ok if successful.
   *
   * @see newStroke()
   */
  virtual ReturnCode addPoint (double aX, double aY) = 0;

  /**
   * @brief Set the text of a text annotation.
   *
   * This function can be used for annotations of type t_freetext.
   *
   * Any sequence of CR and LF characters in the text starts a new
   * paragraph (ie, text following such a sequence will be placed at
   * the beginning of the next output line). In consequence, empty
   * lines in the input do not produce empty lines in the output. To
   * get an empty line in the output, you have to add a paragraph
   * containing a non-breaking space (0xa0) only:
   * @code
   * "Line before empty line\n\xa0\nLine after empty line"
   * @endcode
   *
   * @note This function does not yet support complex scripts.
   *
   * @param[in] aEncoding    The encoding of @a aText and @a aFont.
   * @param[in] aText        The text.  Allowed control characters are
   *                         CR and LF. Any sequence of CR and LF characters
   *                         starts a new paragraph.
   * @param[in] aFont        The name of the font to be used.  The font
   *                         substitition rules of the loaded font
   *                         configuration files will be used. The resulting
   *                         font must be a standard PDF font or a font
   *                         for which a file is specified in the font
   *                         configuration files.
   * @param[in] aFontSize    The font size in user space units.
   * @param[in] aHAlignment  Horizontal alignment of the text.
   *
   * @see getFont(), getPlainText(), SignDocDocumentLoader::loadFontConfigFile(), SignDocDocumentLoader::loadFontConfigEnvironment(), SignDocDocumentLoader::loadFontConfigStream()
   */
  virtual ReturnCode setPlainText (de::softpro::doc::Encoding aEncoding,
                                   const std::string &aText,
                                   const std::string &aFont, double aFontSize,
                                   HAlignment aHAlignment) = 0;

  /**
   * @brief Get the text of a text annotation.
   *
   * @param[in] aEncoding    The encoding to be used for the text returned
   *                         in @a aText.
   *
   * @param[out] aText       The text will be stored here. The start of
   *                         a new paragraph (except for the first one)
   *                         is represented by CR and/or LF characters.
   *
   * @return rc_ok if successful.
   *
   * @see getFont(), setPlainText()
   */
  virtual ReturnCode getPlainText (de::softpro::doc::Encoding aEncoding,
                                   std::string &aText) = 0;

  /**
   * @brief Get the font of a text annotation.
   *
   * @param[in] aEncoding    The encoding to be used for the font name returned
   *                         in @a aFont.
   *
   * @param[out] aFont       The font name will be stored here.
   * @param[out] aFontSize   The font size in user space units will be stored
   *                         here.
   *
   * @return rc_ok if successful.
   *
   * @see getPlainText(), setPlainText()
   *
   * @todo define behavior if there are multiple fonts
   */
  virtual ReturnCode getFont (de::softpro::doc::Encoding aEncoding,
                              std::string &aFont, double &aFontSize) = 0;
};

/**
 * @brief Position of a character.
 *
 * This class uses document coordinates, see @ref signdocshared_coordinates.
 */
class SignDocCharacterPosition
{
public:
  int mPage;                    ///< 1-based page number.
  de::softpro::doc::Point mRef; ///< Reference point.
  de::softpro::doc::Rect mBox;  ///< Bounding box (all four values are zero if not available).
};

/**
 * @brief Position of a hit returned by SignDocDocument::findText().
 */
class SignDocFindTextPosition
{
public:
  SignDocCharacterPosition mFirst;   ///< First character
  SignDocCharacterPosition mLast;    ///< Last character
};

/**
 * @brief Parameters for SignDocDocument::renderPageAsImage(),
 *        SignDocDocument::renderPageAsSpoocImage(), and
 *        SignDocDocument::renderPageAsSpoocImages().
 */
class SPSDEXPORT1 SignDocRenderParameters
{
public:
  /**
   * @brief Interlacing methods for setInterlacing().
   */
  enum Interlacing
  {
    /**
     * @brief No interlacing.
     */
    i_off,

    /**
     * @brief Enable Interlacing.
     *
     * A suitable interlacing method for the chosen image format will be used.
     */
    i_on
  };

  /**
   * @brief Quality of the rendered image.
   */
  enum Quality
  {
    /**
     * @brief Low quality, fast.
     */
    q_low,

    /**
     * @brief High quality, slow.
     */
    q_high
  };

  /**
   * @brief Pixel format for the rendered image.
   */
  enum PixelFormat
  {
    /**
     * @brief RGB for PDF documents, same as document for TIFF documents.
     */
    pf_default,

    /**
     * @brief Black and white (1 bit per pixel)
     */
    pf_bw
  };

  /**
   * @brief Compression for the rendered image.
   *
   * Not all compressions are available for all formats.
   * In fact, all these compressions are available for TIFF only.
   */
  enum Compression
  {
    c_default,     ///< no compression for PDF documents, same as document for TIFF documents
    c_none,        ///< no compression
    c_group4,      ///< CCITT Group 4
    c_lzw,         ///< LZW
    c_rle,         ///< RLE
    c_zip          ///< ZIP
  };

  /**
   * @brief Policy for verification of the certificate chain.
   *
   * @see setCertificateChainVerificationPolicy()
   */
  enum CertificateChainVerificationPolicy
  {
    /**
     * @brief Don't verify certificate chain.
     *
     * Always pretend that the certificate chain is OK.
     */
    ccvp_dont_verify,

    /**
     * @brief Accept self-signed certificates.
     *
     * If the signing certificate is not self-signed, it must chain up
     * to a trusted root certificate.
     */
    ccvp_accept_self_signed,

    /**
     * @brief Accept self-signed certificates if biometric data is present.
     *
     * If the signing certificate is not self-signed or if there is no
     * biometric data, the certificate must chain up to a trusted root
     * certificate.
     */
    ccvp_accept_self_signed_with_bio,

    /**
     * @brief Accept self-signed certificates if asymmetrically encrypted
     *        biometric data is present.
     *
     * If the signing certificate is not self-signed or if there is no
     * biometric data or if the biometric data is not encrypted with
     * RSA, the certificate must chain up to a trusted root
     * certificate.
     */
    ccvp_accept_self_signed_with_rsa_bio,

    /**
     * @brief Require a trusted root certificate.
     *
     * The signing certificate must chain up to a trusted root
     * certificate.
     */
    ccvp_require_trusted_root
  };

  /**
   * @brief Policy for verification of certificate revocation.
   *
   * @see setCertificateRevocationVerificationPolicy()
   */
  enum CertificateRevocationVerificationPolicy
  {
    /**
     * @brief Don't verify revocation of certificates.
     *
     * Always pretend that certificates have not been revoked.
     */
    crvp_dont_check,

    /**
     * @brief Check revocation, assume that certificates are not revoked
     *        if the revocation server is offline.
     */
    crvp_offline,

    /**
     * @brief Check revocation, assume that certificates are revoked
     *        if the revocation server is offline.
     */
    crvp_online
  };

  /**
   * @brief Certificate verification model.
   *
   * @see setVerificationModel()
   */
  enum VerificationModel
  {
    /**
     * @brief Whatever the Windows Crypto API or OpenSSL implements.
     */
    vm_windows,

    /**
     * @brief As specfified by German law.
     *
     * @todo implement this
     * @todo name that law
     */
    vm_german_sig_law
  };

public:
  /**
   * @brief Constructor.
   */
  SignDocRenderParameters ();

  /**
   * @brief Copy constructor.
   *
   * @param[in] aSource  The object to be copied.
   */
  SignDocRenderParameters (const SignDocRenderParameters &aSource);

  /**
   * @brief Destructor.
   */
  ~SignDocRenderParameters ();

  /**
   * @brief Assignment operator.
   *
   * @param[in] aSource  The source object.
   */
  SignDocRenderParameters &operator= (const SignDocRenderParameters &aSource);

  /**
   * @brief "Less than" operator.
   *
   * @param[in] aOther  The object to compare against.
   */
  bool operator< (const SignDocRenderParameters &aOther) const;

  /**
   * @brief Select the page to be rendered.
   *
   * There is no initial value, ie, either this function or
   * setPages() must be called.
   *
   * @param[in]  aPage  The page number (1 for the first page).
   *
   * @return true if successful, false if the page number is invalid.
   *
   * @see getPage(), setPages()
   */
  bool setPage (int aPage);

  /**
   * @brief Get the number of the selected page.
   *
   * @param[out]  aPage  The page number (1 for the first page) will be
   *                     stored here.
   *
   * @return true if successful, false if setPage() has not been called
   *         successfully or if multiple pages have been selected with
   *         setPages()
   *
   * @see getPages(), setPage()
   */
  bool getPage (int &aPage) const;

  /**
   * @brief Select a range of pages to be rendered.
   *
   * There is no initial value, ie, either this function or
   * setPage() must be called.
   *
   * @note If multiple pages are selected, the image format must be "tiff"
   *       for SignDocDocument::renderPageAsImage().
   *
   * @param[in]  aFirst  The first page number of the range (1 for the
   *                     first page of the document).
   * @param[in]  aLast   The last page number of the range (1 for the
   *                     first page of the document).
   *
   * @return true if successful, false if the page numbers are invalid.
   *
   * @see getPages(), setFormat(), setPage()
   *
   * @todo implement for TIFF documents
   */
  bool setPages (int aFirst, int aLast);

  /**
   * @brief Get the selected range of page numbers.
   *
   * @param[out]  aFirst The first page number of the range (1 for the
   *                     first page of the document) will be
   *                     stored here.
   * @param[out]  aLast  The last page number of the range (1 for the
   *                     first page of the document) will be
   *                     stored here.
   *
   * @return true if successful, false if setPage() and setPages() have
   *         not been called.
   *
   * @see getPage(), setPages()
   */
  bool getPages (int &aFirst, int &aLast) const;

  /** @brief Set the resolution for rendering PDF documents.
   *
   * The values passed to this function will be ignored for TIFF
   * documents as the resolution is computed automatically from the
   * zoom factor and the document's resolution.
   *
   * If this function is not called, 96 DPI (subject to change) will
   * be used for rendering PDF documents.
   *
   * @param[in] aResX  Horizontal resolution in DPI.
   * @param[in] aResY  Vertical resolution in DPI.
   *
   * @return true if successful, false if the resolution is invalid.
   *
   * @see getResolution(), setZoom()
   */
  bool setResolution (double aResX, double aResY);

  /** @brief Get the resolution set by setResolution()
   *
   * @param[out] aResX  Horizontal resolution in DPI.
   * @param[out] aResY  Vertical resolution in DPI.
   *
   * @return true if successful, false if setResolution() has not been
   *         called successfully.
   *
   * @see setResolution()
   */
  bool getResolution (double &aResX, double &aResY) const;

  /**
   * @brief Set the zoom factor for rendering.
   *
   * There is no initial value, ie, this function or fitWidth() or
   * fitHeight() or fitRect() must be called.  This function overrides
   * fitWidth(), fitHeight(), and fitRect().
   *
   * @param[in]  aZoom  The zoom factor.
   *
   * @return true if successful, false if the zoom factor is invalid.
   *
   * @see fitHeight(), fitRect(), fitWidth(), getZoom()
   */
  bool setZoom (double aZoom);

  /**
   * @brief Get the zoom factor set by setZoom().
   *
   * This function does not retrieve the zoom factor to be computed for
   * fitWidth(), fitHeight(), and fitRect(). Use SignDocDocument::computeZoom()
   * for that.
   *
   * @param[out]  aZoom  The zoom factor will be stored here.
   *
   * @return true if successful, false if setZoom() has not been
   *         called successfully or has been overridden.
   *
   * @see fitHeight(), fitRect(), fitWidth(), setZoom(), SignDocDocument::computeZoom()
   */
  bool getZoom (double &aZoom) const;

  /**
   * @brief Set the width for automatic computation of the zoom factor
   *        to make the rendered image fit the specified width.
   *
   * This function overrides the zoom factor set by fitHeight(),
   * fitRect(), and setZoom().
   *
   * @param[in]  aWidth  The desired width of the rendered image.
   *
   * @return true if successful, false if the specified width is invalid.
   *
   * @see fitHeight(), fitRect(), getFitWidth(), setZoom(), SignDocDocument::computeZoom()
   */
  bool fitWidth (int aWidth);

  /**
   * @brief Get the width set by fitWidth().
   *
   * @param[out]  aWidth  The width will be stored here.
   *
   * @return true if successful, false if fitWidth() has not been called
   *         successfully or has been overridden.
   *
   * @see fitWidth()
   */
  bool getFitWidth (int &aWidth) const;

  /**
   * @brief Set the height for automatic computation of the zoom factor
   *        to make the rendered image fit the specified height.
   *
   * This function overrides the zoom factor set by fitWidth(),
   * fitRect(), and setZoom().
   *
   * @param[in]  aHeight  The desired height of the rendered image.
   *
   * @return true if successful, false if the specified height is invalid.
   *
   * @see fitRect(), fitWidth(), getFitHeight(), setZoom(), SignDocDocument::computeZoom()
   */
  bool fitHeight (int aHeight);

  /**
   * @brief Get the height set by fitHeight().
   *
   * @param[out]  aHeight  The height will be stored here.
   *
   * @return true if successful, false if fitHeight() has not been called
   *         successfully or has been overridden.
   *
   * @see fitHeight()
   */
  bool getFitHeight (int &aHeight) const;

  /**
   * @brief Set the width and height for automatic computation of the zoom
   *        factor to make the rendered image fit the specified width and
   *        height.
   *
   * This function overrides the zoom factor set by fitWidth(),
   * fitHeight(), and setZoom().
   *
   * @param[in]  aWidth   The desired width of the rendered image.
   * @param[in]  aHeight  The desired height of the rendered image.
   *
   * @return true if successful, false if the specified width or height
   *              is invalid.
   *
   * @see fitHeight(), fitWidth(), getFitRect(), setZoom(), SignDocDocument::computeZoom()
   */
  bool fitRect (int aWidth, int aHeight);

  /**
   * @brief Get the width and height set by fitRect().
   *
   * @param[out]  aWidth   The width will be stored here.
   * @param[out]  aHeight  The height will be stored here.
   *
   * @return true if successful, false if fitRect() has not been called
   *         successfully or has been overridden.
   *
   * @see fitRect()
   */
  bool getFitRect (int &aWidth, int &aHeight) const;

  /**
   * @brief Set the image format.
   *
   * There is no initial value, ie, this function must be called if
   * this object is to be used for SignDocDocument::renderPageAsImage().
   * The image format is ignored for
   * SignDocDocument::renderPageAsSpoocImage() and
   * SignDocDocument::renderPageAsSpoocImages().
   *
   * Currently, this function does not check the image format.
   *
   * @param[in]  aFormat  The desired format of the image ("jpg", "png",
   *                      "tiff", "gif", or "bmp").
   *
   * @return true if successful, false if the image format is invalid.
   *
   * @see getFormat(), setInterlacing()
   */
  bool setFormat (const std::string &aFormat);

  /**
   * @brief Get the image format.
   *
   * @param[out]  aFormat   The image format will be stored here.
   *
   * @return true if successful, false if setFormat() has not been called
   *         successfully.
   *
   * @see setFormat()
   */
  bool getFormat (std::string &aFormat) const;

  /**
   * @brief Set the interlacing method.
   *
   * Interlacing is used for progressive encoding.
   * The initial value is i_off.
   * The interlacing method is ignored for
   * SignDocDocument::renderPageAsSpoocImage().
   *
   * @param[in]  aInterlacing  The interlacing method.
   *
   * @return true if successful, false if the interlacing mode is invalid.
   *
   * @see getInterlacing(), setFormat()
   */
  bool setInterlacing (Interlacing aInterlacing);

  /**
   * @brief Get the interlacing method.
   *
   * @param[out]  aInterlacing   The interlacing mode will be
   *                             stored here.
   *
   * @return true if successful. This function never fails.
   *
   * @see setInterlacing()
   */
  bool getInterlacing (Interlacing &aInterlacing) const;

  /**
   * @brief Set the desired quality.
   *
   * This setting affects scaling of pages of TIFF documents.
   * The initial value is q_low.
   *
   * @param[in]  aQuality  The desired quality.
   *
   * @return true if successful, false if the argument is invalid.
   *
   * @see getQuality()
   */
  bool setQuality (Quality aQuality);

  /**
   * @brief Get the desired quality.
   *
   * @param[out]  aQuality   The quality setting will be stored here.
   *
   * @return true if successful. This function never fails.
   *
   * @see setQuality()
   */
  bool getQuality (Quality &aQuality) const;

  /**
   * @brief Set the pixel format.
   *
   * The initial value is pf_default.
   *
   * @param[in]  aPixelFormat  The pixel format.
   *
   * @return true if successful, false if the argument is invalid.
   *
   * @see getPixelFormat()
   */
  bool setPixelFormat (PixelFormat aPixelFormat);

  /**
   * @brief Get the pixel format.
   *
   * @param[out]  aPixelFormat   The pixel format will be stored here.
   *
   * @return true if successful. This function never fails.
   *
   * @see setPixelFormat()
   */
  bool getPixelFormat (PixelFormat &aPixelFormat) const;

  /**
   * @brief Set the compression compression.
   *
   * The initial value is c_default.
   *
   * @param[in]  aCompression  The compression method.
   *
   * @return true if successful, false if the argument is invalid.
   *
   * @see getCompression()
   */
  bool setCompression (Compression aCompression);

  /**
   * @brief Get the compression method.
   *
   * @param[out]  aCompression   The compression method will be stored here.
   *
   * @return true if successful. This function never fails.
   *
   * @see setCompression()
   */
  bool getCompression (Compression &aCompression) const;

  /**
   * @brief Set the certificate chain verification policy.
   *
   * The certificate chain verification policy is used by
   * SignDocDocument::renderPageAsImage(),
   * SignDocDocument::renderPageAsSpoocImage(), and
   * SignDocDocument::renderPageAsSpoocImages()
   * if setDecorations(true) has been called
   *
   * The default value is ccvp_accept_self_signed_with_rsa_bio.
   * ccvp_require_trusted_root is not implemented for PKCS #1 signatures.
   *
   * @param[in] aPolicy  The certificate chain verification policy.
   *
   * @return true if successful, false if the argument is invalid.
   *
   * @see getCertificateChainVerificationPolicy(), setCertificateRevocationVerificationPolicy(), setVerificationModel(), SignDocDocument::renderPageAsImage(), SignDocDocument::renderPageAsSpoocImage(), SignDocDocument::renderPageAsSpoocImages()
   */
  bool setCertificateChainVerificationPolicy (CertificateChainVerificationPolicy aPolicy);

  /**
   * @brief Get the certificate chain verification policy.
   *
   * See setCertificateChainVerificationPolicy() for details.
   *
   * @param[out] aPolicy  The certificate chain verification policy will
   *                      be stored here.
   *
   * @return true if successful. This function never fails.
   *
   * @see getCertificateRevocationVerificationPolicy(), getVerificationModel(), setCertificateChainVerificationPolicy(), SignDocDocument::renderPageAsImage(), SignDocDocument::renderPageAsSpoocImage(), SignDocDocument::renderPageAsSpoocImages()
   */
  bool getCertificateChainVerificationPolicy (CertificateChainVerificationPolicy &aPolicy) const;

  /**
   * @brief Set the certificate revocation verification policy.
   *
   * The certificate revocation verification policy is used by
   * SignDocDocument::renderPageAsImage(),
   * SignDocDocument::renderPageAsSpoocImage(), and
   * SignDocDocument::renderPageAsSpoocImages()
   * if setDecorations(true) has been called
   *
   * The default value is crvp_dont_check.  crvp_online and crvp_offline
   * are not supported for PKCS #1 signatures.
   *
   * @param[in] aPolicy  The certificate revocation verification policy.
   *
   * @return true if successful, false if the argument is invalid.
   *
   * @see getCertificateRevocationVerificationPolicy(), setCertificateChainVerificationPolicy(), setVerificationModel(), SignDocDocument::renderPageAsImage(), SignDocDocument::renderPageAsSpoocImage(), SignDocDocument::renderPageAsSpoocImages()
   */
  bool setCertificateRevocationVerificationPolicy (CertificateRevocationVerificationPolicy aPolicy);

  /**
   * @brief Get the certificate revocation verification policy.
   *
   * See setCertificateRevocationVerificationPolicy() for details.
   *
   * @param[out] aPolicy  The certificate revocation verification policy will
   *                      be stored here.
   *
   * @return true if successful. This function never fails.
   *
   * @see getCertificateChainVerificationPolicy(), getVerificationModel(), setCertificateRevocationVerificationPolicy(), SignDocDocument::renderPageAsImage(), SignDocDocument::renderPageAsSpoocImage(), SignDocDocument::renderPageAsSpoocImages()
   */
  bool getCertificateRevocationVerificationPolicy (CertificateRevocationVerificationPolicy &aPolicy) const;

  /**
   * @brief Set the certificate verification model.
   *
   * The certificate verification model is used by
   * SignDocDocument::renderPageAsImage(),
   * SignDocDocument::renderPageAsSpoocImage(), and
   * SignDocDocument::renderPageAsSpoocImages()
   * if setDecorations(true) has been called
   *
   * The default value is vm_windows.
   *
   * @param[in] aModel  The certificate verification model.
   *
   * @return true if successful, false if the argument is invalid.
   *
   * @see getVerificationModel(), setCertificateChainVerificationPolicy(), setCertificateRevocationVerificationPolicy(), SignDocDocument::renderPageAsImage(), SignDocDocument::renderPageAsSpoocImage(), SignDocDocument::renderPageAsSpoocImages()
   */
  bool setVerificationModel (VerificationModel aModel);

  /**
   * @brief Get the certificate verification model.
   *
   * See setVerificationModel() for details.
   *
   * @param[out] aModel  The certificate verification model will be stored
   *                     here.
   *
   * @return true if successful. This function never fails.
   *
   * @see getCertificateChainVerificationPolicy(), getCertificateRevocationVerificationPolicy(), setVerificationModel(), SignDocDocument::renderPageAsImage(), SignDocDocument::renderPageAsSpoocImage(), SignDocDocument::renderPageAsSpoocImages()
   */
  bool getVerificationModel (VerificationModel &aModel) const;

  /**
   * @brief Enable rendering of decorations.
   *
   * The default value is false.
   *
   * For PDF documents, pages may optionally be rendered with
   * decorations: An icon visualizing the signature status will be
   * added to each signature field:
   * - no icon (signature field not signed)
   * - green check mark (signature is OK)
   * - green check mark with yellow triangle (signature is OK but the
   *   certificate is not trusted or the document has been extended,
   *   ie, modified and saved incrementally after signing)
   * - red cross (signature broken)
   * .
   *
   * For TIFF documents, this value is ignored; a red cross will be
   * displayed in signature fields if the signature is broken.
   *
   * @param[in]  aDecorations  true to render decorations.
   *
   * @return true if successful. This function never fails.
   *
   * @see getDecorations(), setPrint()
   */
  bool setDecorations (bool aDecorations);

  /**
   * @brief Get the value set by setDecorations().
   *
   * @param[out]  aDecorations  The flag will be stored here.
   *
   * @return true if successful. This function never fails.
   *
   * @see getPrint(), setDecorations()
   */
  bool getDecorations (bool &aDecorations) const;

  /**
   * @brief Enable rendering for printing.
   *
   * The default value is false (render for displaying).
   *
   * @param[in]  aPrint   true to render for printing, false to render
   *                      for displaying.
   *
   * @return true if successful. This function never fails.
   *
   * @see getPrint(), setDecorations()
   */
  bool setPrint (bool aPrint);

  /**
   * @brief Get the value set by setPrint().
   *
   * @param[out]  aPrint  The flag will be stored here.
   *
   * @return true if successful. This function never fails.
   *
   * @see getDecorations(), setPrint()
   */
  bool getPrint (bool &aPrint) const;

  /**
   * @brief Compare against another SignDocRenderParameters object.
   *
   * The exact order of SignDocRenderParameters is unspecified but
   * consistent.
   *
   * @param[in] aOther  The object to compare against.
   *
   * @return -1 if this object compares smaller than @a aOther, 0 if this
   *         object compares equal to @a aOther, 1 if this object compares
   *         greater than @a aOther.
   */
  int compare (const SignDocRenderParameters &aOther) const;

private:
  class Impl;
  Impl *p;
};

/**
 * @brief Output of SignDocDocument::renderPageAsImage(),
 *        SignDocDocument::renderPageAsSpoocImage(), and
 *        SignDocDocument::renderPageAsSpoocImages().
 *
 * If multiple pages are selected (see #SignDocRenderParameters::setPages()),
 * the maximum width and maximum height of all selected pages will be used.
 */
class SignDocRenderOutput
{
public:
  /**
   * @brief The width of the rendered page in pixels.
   */
  int mWidth;

  /**
   * @brief The height of the rendered page in pixels.
   */
  int mHeight;
};

/**
 * @brief Output of SignDocDocument::getAttachment().
 */
class SPSDEXPORT1 SignDocAttachment
{
public:
  class Impl;

public:
  /**
   * @brief Constructor.
   */
  SignDocAttachment ();

  /**
   * @brief Copy constructor.
   *
   * @param[in] aSource  The object to be copied.
   */
  SignDocAttachment (const SignDocAttachment &aSource);

  /**
   * @brief Destructor.
   */
  ~SignDocAttachment ();

  /**
   * @brief Assignment operator.
   *
   * @param[in] aSource  The source object.
   */
  SignDocAttachment &operator= (const SignDocAttachment &aSource);

  /**
   * @brief Efficiently swap this object with another one.
   *
   * @param[in] aOther  The other object.
   */
  void swap (SignDocAttachment &aOther);

  /**
   * @brief Get the name of the attachment.
   *
   * This function throws de::softpro::spooc::EncodingError if
   * the name cannot be represented using the specified encoding.
   *
   * @param[in] aEncoding  The encoding to be used for the return value.
   *
   * @return The name of the attachment.
   *
   * @see getNameUTF8()
   */
  std::string getName (de::softpro::doc::Encoding aEncoding) const;

  /**
   * @brief Get the name of the attachment as UTF-8-encoded C string.
   *
   * @return The name of the attachment.  This pointer will become invalid
   *         when this object is destroyed.
   *
   * @see getName()
   */
  const char *getNameUTF8() const;

  /**
   * @brief Get the file name of the attachment.
   *
   * This function throws de::softpro::spooc::EncodingError if
   * the file name cannot be represented using the specified encoding.
   *
   * @param[in] aEncoding  The encoding to be used for the return value.
   *
   * @return The file name of the attachment.
   *
   * @see getFileNameUTF8()
   */
  std::string getFileName (de::softpro::doc::Encoding aEncoding) const;

  /**
   * @brief Get the file name of the attachment as UTF-8-encoded C string.
   *
   * @return The file name of the attachment.  This pointer will become invalid
   *         when this object is destroyed.
   *
   * @see getFileName()
   */
  const char *getFileNameUTF8() const;

  /**
   * @brief Get the description of the attachment.
   *
   * The returned string will be empty if the description is missing.
   *
   * This function throws de::softpro::spooc::EncodingError if
   * the description cannot be represented using the specified encoding.
   *
   * @param[in] aEncoding  The encoding to be used for the return value.
   *
   * @return The description of the attachment.
   *
   * @see getDescriptionUTF8()
   */
  std::string getDescription (de::softpro::doc::Encoding aEncoding) const;

  /**
   * @brief Get the description of the attachment as UTF-8-encoded C string.
   *
   * The returned string will be empty if the description is missing.
   *
   * @return The description of the attachment.  This pointer will become invalid
   *         when this object is destroyed.
   *
   * @see getDescription()
   */
  const char *getDescriptionUTF8() const;

  /**
   * @brief Get the size (in octets) of the attachment.
   *
   * The return value is -1 if the size of the attachment is not readily
   * available.
   *
   * @return The size (in octets) of the attachment or -1.
   *
   * @see getCompressedSize()
   */
  int getSize () const;

  /**
   * @brief Get the compressed size (in octets) of the attachment.
   *
   * @return The compressed size (in octets) of the attachment.
   *
   * @see getSize()
   */
  int getCompressedSize () const;

  /**
   * @brief Get the MIME type of the attachment.
   *
   * The return string will be empty if the MIME type is missing.
   *
   * @return The MIME type of the attachment.  This pointer will become invalid
   *         when this object is destroyed.
   */
  const char *getType() const;

  /**
   * @brief Get the creation time and date of the attachment.
   *
   * The returned string will be empty if the creation time and date
   * are missing.
   *
   * ISO 8601 format is used: yyyy-mm-ddThh:mm:ss, optionally followed by
   * a timezone: Z, +hh:mm, or -hh:mm.
   *
   * The PDF reference is ambiguous; apparently, the creation time is
   * supposed to be the time and date at which the attachment was the
   * PDF document. Changing the description does not update the
   * modification date/time.
   *
   * @return The creation time and date of the attachment.
   *         This pointer will become invalid when this object is destroyed.
   *
   * @see getModificationTime()
   */
  const char *getCreationTime () const;

  /**
   * @brief Get the time and date of the last modification of the
   *        attachment.
   *
   * Setting the time and date of the last modification of the attachment is
   * optional.
   * The returned string will be empty if the modification time and date
   * are missing.
   *
   * ISO 8601 format is used: yyyy-mm-ddThh:mm:ss, optionally followed by
   * a timezone: Z, +hh:mm, or -hh:mm.
   *
   * The PDF reference is ambiguous; apparently, the modifiation time
   * is supposed to be the time and date of the last modification of
   * the file at the time it was attached. Changing the description
   * does not update the modification date/time.
   *
   * @return The time and date of the last modification of the attachment.
   *         This pointer will become invalid when this object is destroyed.
   */
  const char *getModificationTime () const;

  /**
   * @brief Internal use only.
   * @internal
   */
  Impl *getImpl ();

  /**
   * @brief Internal use only.
   * @internal
   */
  const Impl *getImpl () const;

private:
  Impl *p;
};

/**
 * @brief Parameters for a watermark.
 *
 * @see SignDocDocument::addWatermark()
 *
 * @todo fromFile(): PDF/image, page number, absolute scale
 * @todo setUnderline()
 */
class SPSDEXPORT1 SignDocWatermark
{
public:
  class Impl;

  /**
   * @brief Justification of  multi-line text.
   */
  enum Justification
  {
    j_left, j_center, j_right
  };

  /**
   * @brief Location of watermark.
   */
  enum Location
  {
    l_overlay,                  ///< Watermark appears on top of page
    l_underlay                  ///< Watermark appears behind page
  };

  /**
   * @brief Horizontal alignment.
   */
  enum HAlignment
  {
    ha_left, ha_center, ha_right
  };

  /**
   * @brief Vertical alignment.
   */
  enum VAlignment
  {
    va_top, va_center, va_bottom
  };

public:
  /**
   * @brief Constructor.
   *
   * All parameters are set to their default values.
   */
  SignDocWatermark ();

  /**
   * @brief Copy constructor.
   *
   * @param[in] aSource  The object to be copied.
   */
  SignDocWatermark (const SignDocWatermark &aSource);

  /**
   * @brief Destructor.
   */
  ~SignDocWatermark ();

  /**
   * @brief Assignment operator.
   *
   * @param[in] aSource  The source object.
   */
  SignDocWatermark &operator= (const SignDocWatermark &aSource);

  /**
   * @brief Efficiently swap this object with another one.
   *
   * @param[in] aOther  The other object.
   */
  void swap (SignDocWatermark &aOther);

  /**
   * @brief Reset all parameters to their default values.
   */
  void clear ();

  /**
   * @brief Set the text to be used for the watermark.
   *
   * The default value is empty.
   *
   * The text can contain multiple lines, the newline character is
   * used to separate lines.  If there are multiple lines, their
   * relative position is specified by setJustification().
   *
   * @param[in] aEncoding   The encoding of @a aText.
   * @param[in] aText       The text. Complex scripts are supported,
   *                        see @ref signdocshared_complex_scripts.
   *
   * @see setFontName(), setFontSize(), setJustification(), setTextColor()
   */
  void setText (de::softpro::doc::Encoding aEncoding,
                const std::string &aText);

  /**
   * @brief Set the name of the font.
   *
   * The font name can be the name of a standard font, the name of an
   * already embedded font, or the name of a font defined by a font
   * configuration file.
   *
   * The default value is "Helvetica".
   *
   * @param[in] aEncoding  The encoding of @a aFontName.
   * @param[in] aFontName  The new font name.
   *
   * @see setFontSize(), setTextColor(), SignDocDocumentLoader::loadFontConfigFile(), SignDocDocumentLoader::loadFontConfigEnvironment(), SignDocDocumentLoader::loadFontConfigStream()
   */
  void setFontName (de::softpro::doc::Encoding aEncoding,
                    const std::string &aFontName);

  /**
   * @brief Set the font size.
   *
   * The default value is 24.
   *
   * @param[in] aFontSize  The font size (in user space units).
   *
   * @see setFontName(), setScale()
   */
  void setFontSize (double aFontSize);

  /**
   * @brief Set the text color.
   *
   * The default value is SignDocGrayColor(0) (black).
   *
   * @param[in] aTextColor  The text color.
   */
  void setTextColor (const SignDocColor &aTextColor);

  /**
   * @brief Set the justification for multi-line text.
   *
   * The default value is j_left.
   *
   * If the text (see setText()) contains only one line (ie, no
   * newline characters), this parameter will be ignored.
   *
   * @param[in] aJustification  The justification.
   *
   * @see setText()
   */
  void setJustification (Justification aJustification);

  /**
   * @brief Set the rotation.
   *
   * The default value is 0.
   *
   * @param[in] aRotation  The rotation in degrees (-180 through 180),
   *                       0 is horizontal (left to right),
   *                       45 is bottom left to upper right.
   */
  void setRotation (double aRotation);

  /**
   * @brief Set the opacity.
   *
   * The default value is 1.0. Documents conforming to PDF/A must
   * use an opacity of 1.0.
   *
   * @param[in] aOpacity  The opacity, 0.0 (transparent) through 1.0 (opaque).
   *
   * @see setLocation()
   */
  void setOpacity (double aOpacity);

  /**
   * @brief Disable scaling or set scaling relative to page.
   *
   * The default value is 0.5.
   *
   * @param[in] aScale  0 to disable scaling (use the font size set by
   *                    setFontSize()) or 0.01 through 64.0 to scale
   *                    relative to the page size.
   */
  void setScale (double aScale);

  /**
   * @brief Set whether the watermark will appear behind the page or
   *        on top of the page.
   *
   * The default value is l_overlay.
   *
   * @param[in] aLocation   l_overlay or l_underlay.
   *
   * @see setOpacity()
   */
  void setLocation (Location aLocation);

  /**
   * @brief Set the horizontal position of the watermark.
   *
   * The default values are ha_center and 0.
   *
   * The distance is measured from the left edge of the page to the
   * left edge of the watermark (ha_left), from the center of the page
   * to the center of the watermark (ha_center), or from the right
   * edge of the page to the right edge of the watermark.
   *
   * For ha_left and ha_center, positive values push the watermark to
   * the right, for ha_right, positive values push the watermark to
   * the left.

   * @param[in] aAlignment  Measure distance from here.
   * @param[in] aDistance   The distance in user space units.
   *
   * @see setScale(), setVerticalPosition()
   */
  void setHorizontalPosition (HAlignment aAlignment, double aDistance);

  /**
   * @brief Set the vertical position of the watermark.
   *
   * The default values are va_center and 0.
   *
   * The distance is measured from the top edge of the page to the
   * top edge of the watermark (va_top), from the center of the page
   * to the center of the watermark (va_center), or from the bottom
   * edge of the page to the bottom edge of the watermark.
   *
   * For va_bottom and va_center, positive values push the watermark
   * up, for va_top, positive values push the watermark down.
   *
   * @param[in] aAlignment  Measure distance from here.
   * @param[in] aDistance   The distance in user space units.
   *
   * @see setHorizontalPosition(), setScale()
   */
  void setVerticalPosition (VAlignment aAlignment, double aDistance);

  /**
   * @brief Set the first page number.
   *
   * The default value is 1.
   *
   * @param[in] aPage  The 1-based page number of the first page.
   *
   * @see setLastPage(), setPageIncrement()
   */
  void setFirstPage (int aPage);

  /**
   * @brief Set the last page number.
   *
   * The default value is 0.
   *
   * @param[in] aPage  The 1-based page number of the last page or
   *                   0 for the last page of the document.
   *
   * @see setFirstPage(), setPageIncrement()
   */
  void setLastPage (int aPage);

  /**
   * @brief Set the page number increment.
   *
   * The default value is 1 (add watermark to all pages between
   * the first page and the last page)
   *
   * @param[in] aIncr  Add this number to the page number when iterating
   *                   over pages adding watermarks.  Must be positive.
   *
   * @see setFirstPage(), setLastPage()
   */
  void setPageIncrement (int aIncr);

  /**
   * @brief Internal use only.
   * @internal
   */
  Impl *getImpl ();

  /**
   * @brief Internal use only.
   * @internal
   */
  const Impl *getImpl () const;

private:
  Impl *p;
};

class SignDocVerificationResult;

/**
 * @brief An interface for SignDoc documents.
 *
 * An object of this class represents one document.
 *
 * Use SignDocDocumentLoader::loadFromMemory() or
 * SignDocDocumentLoader::loadFromFile() to create objects.
 *
 * If the document is loaded from a file, the file may remain in
 * use until this object is destroyed or the document is saved
 * to a different file with saveToFile(). Please do not change the
 * file while there is a SignDocDocument object for it.
 *
 * @todo add fixFields()
 */
class SignDocDocument : private de::softpro::spooc::NonCopyable
{
public:
  /**
   * @brief Supported document types.
   */
  enum DocumentType
  {
    dt_unknown,                 ///< For SignDocDocumentLoader::ping().
    dt_pdf,                     ///< PDF document.
    dt_tiff,                    ///< TIFF document.
    dt_other,                   ///< Other document.
    dt_fdf                      ///< FDF document.
  };

  /**
   * @brief Flags modifying the behavior of saveToFile() and saveToStream().
   */
  enum SaveFlags
  {
    /**
     * @brief Save incrementally (PDF).
     */
    sf_incremental   = 0x01,

    /**
     * @brief Remove unused objects (PDF).
     *
     * This flag is ignored, unused objects are always removed.
     */
    sf_remove_unused = 0x02,

    /**
     * @brief Linearize the document (PDF).
     *
     * This flag cannot be used with sf_incremental.
     */
    sf_linearized    = 0x04,

    /**
     * @brief Do not use features introduced after PDF 1.4 for saving the document.
     *
     * This flag is assumed to be set for PDF 1.4 (and older) documents (PDF).
     */
    sf_pdf_1_4       = 0x08,

    /**
     * @brief Fix appearance streams of check boxes and radio buttons
     *        for PDF/A documents.
     *
     * The appearance streams of a check box or radio button field added
     * by addField() or modified by setField() are not PDF/A-compliant.
     *
     * To make the appearance streams of check boxes and radio buttons
     * PDF/A-compliant, save the document with this flag set. The document
     * will be modified in memory and then saved.
     *
     * This flag is observed even if the document does not claim to be
     * PDF/A-compliant.
     *
     * @note After fixing appearance streams, check boxes and radio buttons
     *       can no longer be modified or operated as the button values 
     *       (ie, the set of possible values) is lost.
     *
     * @see SignDocSignatureParameters::pb_auto, SignDocSignatureParameters::pb_freeze
     */
    sf_pdfa_buttons  = 0x10
  };

  /**
   * @brief Flags modifying the behavior of setField() and addField().
   *
   * Exactly one of sff_font_fail, sff_font_warn, and sff_font_ignore
   * must be specified.
   */
  enum SetFieldFlags
  {
    /**
     * @brief Fail if no suitable font is found.
     *
     * setField() and addField() won't modify/add the field and will
     * report error rc_font_not_found if no font covering all required
     * characters is found.
     */
    sff_font_fail    = 0x01,

    /**
     * @brief Warn if no suitable font is found.
     *
     * setField() and addField() will modify/add the field even if no
     * font covering all required characters is found, but they will
     * report error rc_font_not_found. The appearance of the field
     * won't represent the contents in that case.
     */
    sff_font_warn    = 0x02,

    /**
     * @brief Ignore font problems.
     *
     * setField() and addField() will modify/add the field even if no
     * font covering all required characters is found, and they won't
     * report the problem to the caller. The appearance of the field
     * won't represent the contents in that case.
     */
    sff_font_ignore  = 0x04
  };

  /**
   * @brief Flags modifying the behavior of findText().
   */
  enum FindTextFlags
  {
    ftf_ignore_hspace      = 0x0001,  ///< Ignore horizontal whitespace (may be required)
    ftf_ignore_hyphenation = 0x0002,  ///< Ignore hyphenation (not yet implemented)
    ftf_ignore_sequence    = 0x0004   ///< Use character positions instead of sequence (can be expensive, not yet implemented)
  };

  /**
   * @brief Flags modifying the behavior of exportFields() and exportProperties().
   */
  enum ExportFlags
  {
    e_top = 0x01  ///< Include XML declaration and schema for top-level element
  };

  /**
   * @brief Flags modifying the behavior of importProperties().
   */
  enum ImportFlags
  {
    i_atomic = 0x01  ///< Modify all properties from XML or none (on error)
  };

  /**
   * @brief Flags modifying the behavior of addImageFromBlob(),
   *        addImageFromFile(), importPageFromImageBlob(), and
   *        importPageFromImageFile().
   */
  enum ImportImageFlags
  {
    /**
     * @brief Keep aspect ratio of image, center image on white background.
     */
    ii_keep_aspect_ratio = 0x01,

    /**
     * @brief Make the brightest color transparent.
     *
     * This flag may be specified for addImageFromBlob() and addImageFromFile()
     * only. importPageFromImageBlob() and importPageFromImageFile() always
     * make the image opaque.
     *
     * The rest of this description applies to addImageFromBlob() and
     * addImageFromFile() only.
     *
     * If the image has an alpha channel (or if its palette contains a
     * transparent color), this flag will be ignored and the image's
     * transparency will be used.
     *
     * Transparency is not supported for JPEG images and JPEG-compressed
     * TIFF images.
     *
     * If this flag is not set, the image will be opaque unless the
     * image has an alpha channel or transparent colors in its
     * palette.
     *
     * If this flag is set (and the image doesn't have an alpha
     * channel and doesn't have transparent colors in its palette),
     * white will be made transparent for truecolor images and the
     * brightest color in the palette will be made transparent for
     * indexed images (including grayscale images).
     */
    ii_brightest_transparent = 0x02
  };

  /**
   * @brief Tell removePages() to keep or to remove the specified pages.
   */
  enum KeepOrRemove
  {
    kor_keep,                   ///< Keep the specified pages, remove all other pages
    kor_remove                  ///< Remove the specified pages, keep all other pages
  };

  /**
   * @brief Return codes.
   *
   * Do not forget to update de/softpro/doc/SignDocException.java!
   */
  enum ReturnCode
  {
    rc_ok,                    ///< No error
    rc_invalid_argument,      ///< Invalid argument
    rc_field_not_found,       ///< Field not found (or not a signature field)
    rc_invalid_profile,       ///< Profile unknown or not applicable
    rc_invalid_image,         ///< Invalid image (e.g., unsupported format)
    rc_type_mismatch,         ///< Field type or property type mismatch
    rc_font_not_found,        ///< The requested font could not be found or does not contain all required characters
    rc_no_datablock,          ///< No datablock found
    rc_not_supported,         ///< Operation not supported
    rc_io_error,              ///< I/O error
    rc_not_verified,          ///< (used by SignDocVerificationResult)
    rc_property_not_found,    ///< Property not found
    rc_page_not_found,        ///< Page not found (invalid page number)
    rc_wrong_collection,      ///< Property accessed via wrong collection
    rc_field_exists,          ///< Field already exists
    rc_license_error,         ///< License initialization failed or license check failed
    rc_unexpected_error,      ///< Unexpected error
    rc_cancelled,             ///< Certificate dialog cancelled by user
    rc_no_biometric_data,     ///< (used by SignDocVerificationResult)
    rc_parameter_not_set,     ///< (Java only)
    rc_field_not_signed,      ///< Field not signed, for copyAsSignedToStream()
    rc_invalid_signature,     ///< Signature is not valid, for copyAsSignedToStream()
    rc_annotation_not_found,  ///< Annotation not found, for getAnnotation()
    rc_attachment_not_found,  ///< Attachment not found
    rc_attachment_exists,     ///< Attachment already exists
    rc_no_certificate,        ///< No (matching) certificate found and csf_create_self_signed is not specified
    rc_ambiguous_certificate  ///< More than one matching certificate found and csf_never_ask is specified
  };

  /**
   * @brief Result of checkAttachment().
   */
  enum CheckAttachmentResult
  {
    car_match,                  ///< The attachment matches its checksum
    car_no_checksum,            ///< The attachment does not have a checksum
    car_mismatch                ///< The attachment does not match its checksum
  };

  /**
   * @brief Horizontal alignment for addTextRect().
   */
  enum HAlignment
  {
    ha_left, ha_center, ha_right
  };

  /**
   * @brief Vertical alignment for addTextRect().
   */
  enum VAlignment
  {
    va_top, va_center, va_bottom
  };

  /**
   * @brief Constructor.
   *
   * Use SignDocDocumentLoader::loadFromMemory() or
   * SignDocDocumentLoader::loadFromFile() to create objects.
   */
  SignDocDocument () { }

  /**
   * @brief Destructor.
   */
  virtual ~SignDocDocument () { }

  /**
   * @brief Get the type of the document.
   *
   * @return The document type.
   */
  virtual DocumentType getType () const = 0;

  /**
   * @brief Get the number of pages.
   *
   * @return The number of pages.
   */
  virtual int getPageCount () const = 0;

  /**
   * @brief Create a SignDocSignatureParameters object for signing a
   *        signature field.
   *
   * The caller is responsible for destroying the object.
   *
   * Any SignDocSignatureParameters object should be used for at most
   * one signature.
   *
   * @param[in] aEncoding    The encoding of @a aFieldName.
   * @param[in] aFieldName   The name of the signature field, encoded according
   *                         to @a aEncoding.
   * @param[in] aProfile     The profile name (ASCII). Some document types and
   *                         signature fields support different sets of default
   *                         parameters. For instance, DigSig fields of
   *                         PDF documents have a "FinanzIT" profile. The
   *                         default profile, "", is supported for all
   *                         signature fields.
   * @param[out] aOutput     A pointer to the new parameters object will be
   *                         stored here. The caller is responsible for
   *                         destroying the object.
   *
   * @return rc_ok if successful.
   *
   * @see addSignature(), getProfiles()
   */
  virtual ReturnCode createSignatureParameters (de::softpro::doc::Encoding aEncoding,
                                                const std::string &aFieldName,
                                                const std::string &aProfile,
                                                SignDocSignatureParameters *&aOutput) = 0;

  /**
   * @brief Get a list of profiles for a signature field.
   *
   * @param[in]  aEncoding    The encoding of @a aFieldName.
   * @param[in]  aFieldName   The name of the signature field encoded according
   *                          to @a aEncoding.
   * @param[out] aOutput      The names (ASCII) of all profiles supported by
   *                          the signature field will be stored here,
   *                          excluding the default profile "" which is
   *                          always available.
   *
   * @return rc_ok if successful.
   *
   * @see createSignatureParameters()
   */
  virtual ReturnCode getProfiles (de::softpro::doc::Encoding aEncoding,
                                  const std::string &aFieldName,
                                  std::vector<std::string> &aOutput) = 0;

  /**
   * @brief Sign the document.
   *
   * This function stores changed properties in the document before
   * signing.  If the string parameter "OutputPath" is set, the
   * document will be stored in a new file specified by that
   * parameter.  If string parameter "TemporaryDirectory" is set (and
   * "OutputPath" is not set), the document will be stored in a new
   * temporary file.  Use getPathname() to obtain the pathname of that
   * temporary file.  In either case, the original file won't be
   * modified (however, it will be deleted if it is a temporary file,
   * ie, if "TemporaryDirectory" was used). If neither "OutputPath"
   * nor "TemporaryDirectory" is set, the document will be written to
   * the file from which it was loaded or to which it was most
   * recently saved.
   *
   * Some document types may allow adding signatures only if all signatures
   * of the documents are valid.
   *
   * @param[in] aParameters    The signing parameters.
   *
   * @return rc_ok if successful.
   *
   * @see createSignatureParameters(), getPathname(), setStringProperty()
   */
  virtual ReturnCode addSignature (const SignDocSignatureParameters *aParameters) = 0;

  /**
   * @brief Get the timestamp used by the last successful call of
   *        addSignature().
   *
   * This function may return a timestamp even if the last call of
   * addSignature() was not successful. See also string parameters
   * "Timestamp" and "TimeStampServerURL" of SignDocSignatureParameters.
   *
   * @param[out] aTime  The timestamp in ISO 8601 format (yyyy-mm-ddThh:mm:ss
   *                    without milliseconds, with optional timezone
   *                    (or an empty string if there is no timestamp available)
   *                    will be stored here.
   *
   * @return rc_ok if successful.
   *
   * @see addSignature(), getSignatureString(), SignDocSignatureParameters::setString()
   */
  virtual ReturnCode getLastTimestamp (std::string &aTime) = 0;

  /**
   * @brief Get the current pathname of the document.
   *
   * The pathname will be empty if the document is stored in memory
   * (ie, if it has been loaded from memory or saved to a stream).
   *
   * If a FDF document has been opened, this function will return
   * the pathname of the referenced PDF file.
   *
   * @param[in]  aEncoding  The encoding to be used for @a aPath.
   * @param[out] aPath  The pathname will be stored here.
   *
   * @return rc_ok if successful.
   */
  virtual ReturnCode getPathname (de::softpro::doc::Encoding aEncoding,
                                  std::string &aPath) = 0;

  /**
   * @brief Get a bitset indicating which signing methods are available
   *        for this document.
   *
   * This document's signature fields offer a subset of the signing methods
   * returned by this function.
   *
   * @return 1<<SignDocSignatureParameters::m_signdoc etc.
   *
   * @see SignDocSignatureParameters::getAvailableMethods()
   */
  virtual int getAvailableMethods () = 0;

  /**
   * @brief Verify a signature of the document.
   *
   * @param[in]  aEncoding   The encoding of @a aFieldName.
   * @param[in]  aFieldName  The name of the signature field encoded according
   *                         to @a aEncoding.
   * @param[out] aOutput     A pointer to a new SignDocVerificationResult
   *                         object or NULL will be stored here. The caller
   *                         is responsible for destroying that object.
   *
   * @return rc_ok if successful.
   */
  virtual ReturnCode verifySignature (de::softpro::doc::Encoding aEncoding,
                                      const std::string &aFieldName,
                                      SignDocVerificationResult *&aOutput) = 0;

  /**
   * @brief Remove a signature of the document.
   *
   * For some document formats (TIFF), signatures may only be cleared in
   * the reverse order of signing (LIFO).
   *
   * @param[in]  aEncoding   The encoding of @a aFieldName.
   * @param[in]  aFieldName  The name of the signature field encoded according
   *                         to @a aEncoding.
   *
   * @return rc_ok if successful.
   *
   * @see clearAllSignatures(), getFields(), SignDocField::isCurrentlyClearable()
   */
  virtual ReturnCode clearSignature (de::softpro::doc::Encoding aEncoding,
                                     const std::string &aFieldName) = 0;

  /**
   * @brief Remove all signature of the document.
   *
   * @return rc_ok if successful.
   *
   * @see clearSignature()
   */
  virtual ReturnCode clearAllSignatures () = 0;

  /**
   * @brief Save the document to a stream.
   *
   * This function may have side effects on the document such as
   * marking it as not modified which may render sf_incremental
   * useless for the next saveToFile() call unless the document is
   * changed between those two calls. sf_incremental is not supported
   * by this function.
   *
   * @param[in]  aStream  The document will be saved to this stream.
   * @param[in]  aFlags   Set of flags (of enum #SaveFlags, combined with `|')
   *                      modifying the behavior of this function.
   *                      Pass 0 for no flags.
   *                      Which flags are available depends on the document
   *                      type.
   *
   * @return rc_ok if successful.
   *
   * @see copyToStream(), getSaveToStreamFlags(), saveToFile(), SignDocDocumentLoader::loadFromFile(), SignDocDocumentLoader::loadFromMemory()
   */
  virtual ReturnCode saveToStream (de::softpro::spooc::OutputStream &aStream,
                                   int aFlags) = 0;

  /**
   * @brief Save the document to a file.
   *
   * After a successful call to this function, the document behaves as
   * if it had been loaded from the specified file. sf_incremental is
   * supported only if NULL is passed for @a aPath, that is, when
   * saving to the file from which the document was loaded or to which
   * the document was most recently saved (by saveToFile(), not by
   * saveToStream()).
   *
   * Saving a signed PDF document without sf_incremental will break
   * all signatures, see getRequiredSaveToFileFlags().
   *
   * @param[in] aEncoding  The encoding of the string pointed to by @a aPath.
   * @param[in]  aPath  The pathname of the file to be created or overwritten.
   *                    Pass NULL to save to the file from which the document
   *                    was loaded or most recently saved (which will
   *                    fail if the documment was loaded from memory
   *                    or saved to a stream).
   * @param[in]  aFlags   Set of flags (of enum #SaveFlags, combined with `|')
   *                      modifying the behavior of this function.
   *                      Pass 0 for no flags.
   *                      Which flags are available depends on the document
   *                      type.
   *
   * @return rc_ok if successful.
   *
   * @see copyToStream(), getRequiredSaveToFileFlags(), getSaveToFileFlags(), saveToStream(), SignDocDocumentLoader::loadFromFile(), SignDocDocumentLoader::loadFromMemory()
   */
  virtual ReturnCode saveToFile (de::softpro::doc::Encoding aEncoding,
                                 const char *aPath, int aFlags) = 0;

  /**
   * @brief Save the document to a file.
   *
   * After a successful call to this function, the document behaves as
   * if it had been loaded from the specified file. sf_incremental is
   * supported only if NULL is passed for @a aPath, that is, when
   * saving to the file from which the document was loaded or to which
   * the document was most recently saved (by saveToFile(), not by
   * saveToStream()).
   *
   * Saving a signed PDF document without sf_incremental will break
   * all signatures.
   *
   * @param[in]  aPath  The pathname of the file to be created or overwritten.
   *                    Pass NULL to save to the file from which the document
   *                    was loaded or most recently saved (which will
   *                    fail if the documment was loaded from memory
   *                    or saved to a stream).
   * @param[in]  aFlags   Set of flags (of enum #SaveFlags, combined with `|')
   *                      modifying the behavior of this function.
   *                      Pass 0 for no flags.
   *                      Which flags are available depends on the document
   *                      type.
   *
   * @return rc_ok if successful.
   *
   * @see copyToStream(), getSaveToFileFlags(), saveToStream(), SignDocDocumentLoader::loadFromFile(), SignDocDocumentLoader::loadFromMemory()
   */
  virtual ReturnCode saveToFile (const wchar_t *aPath, int aFlags) = 0;

  /**
   * @brief Copy the document's backing file to a stream.
   *
   * This function copies to a stream the file from which the document
   * was loaded or to which the document was most recently
   * saved. Changes made to the in-memory copy of the document since
   * it was loaded or saved will not be reflected in the copy written
   * to the stream.  This function does not have side effects on the
   * document. This function will fail (returning rc_not_supported) if
   * the document has not been saved to a file since it was loaded
   * from memory or saved to a stream.
   *
   * @param[in]  aStream  The file will be copied to this stream.
   *
   * @return rc_ok if successful.
   *
   * @see copyAsSignedToStream(), saveToFile(), saveToStream(), SignDocDocumentLoader::loadFromFile(), SignDocDocumentLoader::loadFromMemory()
   */
  virtual ReturnCode copyToStream (de::softpro::spooc::OutputStream &aStream) = 0;

  /**
   * @brief Copy the document to a stream for viewing the document "as signed".
   *
   * This function copies to a stream the document as it was when the specified
   * signature field was signed.  If the specified signature field contains
   * the last signature applied to the document, this function is equivalent
   * to copyToStream(). However, for some document formats, this function
   * may require signatures to be valid.
   *
   * @param[in]  aEncoding    The encoding of @a aFieldName.
   * @param[in]  aFieldName   The name of the signature field encoded according
   *                          to @a aEncoding.
   * @param[in]  aStream      The file will be copied to this stream.
   *
   * @return rc_ok if successful.
   *
   * @see copyToStream(), SignDocDocumentLoader::loadFromMemory()
   */
  virtual ReturnCode copyAsSignedToStream (de::softpro::doc::Encoding aEncoding,
                                           const std::string &aFieldName,
                                           de::softpro::spooc::OutputStream &aStream) = 0;

  /**
   * @brief Get all flags currently valid for saveToStream().
   *
   * sf_pdfa_buttons is returned only if the document claims to be
   * PDF/A-compliant.
   *
   * @param[out]  aOutput  The flags will be stored here.
   *
   * @return rc_ok if successful.
   *
   * @see getSaveToFileFlags(), saveToStream()
   */
  virtual ReturnCode getSaveToStreamFlags (int &aOutput) = 0;

  /**
   * @brief Get all flags currently valid for saveToFile().
   *
   * Note that sf_incremental cannot be used together with
   * sf_linearized even if all these flags are returned by this
   * function. sf_pdfa_buttons is returned only if the document
   * claims to be PDF/A-compliant.
   *
   * @param[out]  aOutput  The flags will be stored here.
   *
   * @return rc_ok if successful.
   *
   * @see getRequiredSaveToFileFlags(), getSaveToStreamFlags(), saveToFile()
   */
  virtual ReturnCode getSaveToFileFlags (int &aOutput) = 0;

  /**
   * @brief Get all flags currently required for saveToFile().
   *
   * This function currently stores #sf_incremental (saving the document
   * non-incrementally would destroy existing signatures) or 0 (the
   * document may be saved non-incrementally) to @a aOutput.
   *
   * @param[out]  aOutput  The flags will be stored here.
   *
   * @return rc_ok if successful.
   *
   * @see getSaveToFileFlags(), getSaveToStreamFlags(), saveToFile()
   */
  virtual ReturnCode getRequiredSaveToFileFlags (int &aOutput) = 0;

  /**
   * @brief Get all interactive fields of the specified types.
   *
   * @param[in]  aTypes   0 to get fields of all types.  Otherwise, a bitset
   *                      selecting the field types to be included. To include
   *                      a field of type t, add 1<<t, where t is a value of
   *                      SignDocField::Type.
   * @param[out] aOutput  The fields will be stored here.  They appear
   *                      in the order in which they have been defined.
   *
   * @return rc_ok if successful.
   *
   * @see exportFields(), getField(), getFieldsOfPage()
   */
  virtual ReturnCode getFields (int aTypes,
                                std::vector<SignDocField> &aOutput) = 0;

  /**
   * @brief Get all interactive fields of the specified page, in tab order.
   *
   * If the document does not specify a tab order, the fields will be
   * returned in widget order.
   *
   * @note Structure order (S) is not yet supported.  If the page specifies
   *       structure order, the fields will be returned in widget order.
   *
   * @param[in]  aPage    The 1-based page number.
   * @param[in]  aTypes   0 to get fields of all types.  Otherwise, a bitset
   *                      selecting the field types to be included. To include
   *                      a field of type t, add 1<<t, where t is a value of
   *                      SignDocField::Type.
   * @param[out] aOutput  The fields will be stored here in tab order.
   *
   * @return rc_ok if successful.
   *
   * @see exportFields(), getField(), getFields()
   */
  virtual ReturnCode getFieldsOfPage (int aPage, int aTypes,
                                      std::vector<SignDocField> &aOutput) = 0;

  /**
   * @brief Get an interactive field by name.
   *
   * @param[in]  aEncoding  The encoding of @a aName.
   * @param[in]  aName    The fully-qualified name of the field.
   * @param[out] aOutput  The field will be stored here.
   *
   * @return rc_ok if successful.
   *
   * @see getFields(), setField()
   */
  virtual ReturnCode getField (de::softpro::doc::Encoding aEncoding,
                               const std::string &aName,
                               SignDocField &aOutput) = 0;

  /**
   * @brief Change a field.
   *
   * This function changes a field in the document using attributes
   * from a SignDocField object. Everything except for the name and
   * the type of the field can be changed. See the member functions of
   * SignDocField for details.
   *
   * Always get a SignDocField object for a field by calling
   * getField(), getFields(), or getFields(), then apply your
   * modifications to that object, then call setField().
   *
   * Do not try to build a SignDocField object from scratch for
   * changing a field as future versions of the SignDocField class may
   * have additional attributes.
   *
   * This function is implemented for PDF documents only.
   *
   * This function always fails for PDF documents that have signed
   * signature fields.
   *
   * @param[in,out]  aField    The field to be changed.  The font resource
   *                           name of the default text field attributes
   *                           may be modified. The value index and the
   *                           value may be modified
   *                           for radio button fields and check box fields.
   * @param[in]      aFlags    Flags modifying the behavior of this function,
   *                           see enum #SetFieldFlags.
   *
   * @return rc_ok if successful.
   *
   * @see addField(), getFields(), removeField()
   */
  virtual ReturnCode setField (SignDocField &aField,
                               unsigned aFlags) = 0;

  /**
   * @brief Add a field.
   *
   * See the members of SignDocField for details.
   *
   * This function can add check boxes, radio button groups,
   * text fields, and signature fields to PDF documents.
   *
   * When adding a radio button group or a check box
   * field, a value must be set, see SignDocField::setValue() and
   * SignDocField::setValueIndex().
   *
   * The SignDocField::f_NoToggleToOff flag should be set for all
   * radio button groups.  Adobe products seem to ignore this flag
   * being not set.
   *
   * When adding a text field, the justification must be set with
   * SignDocField::setJustification().
   *
   * Currently, you don't have control over the appearance of the
   * field being inserted except for the text field attributes.
   *
   * Adding a field to a PDF document that doesn't contain any fields
   * will set the document's default text field attributes to font
   * Helvetica, font size 0, text color black.
   *
   * Only signature fields can be added to PDF documents having signed
   * signature fields.
   *
   * TIFF documents support signature fields only and all signature
   * fields must be inserted before the first signature is added to
   * the document (you may want to use invisible fields) unless all
   * existing signature fields have flag f_EnableAddAfterSigning set.
   *
   * @param[in,out]  aField    The new field.  The font resource
   *                           name of the default text field attributes
   *                           may be modified. The value index and the
   *                           value may be modified
   *                           for radio button fields and check box fields.
   * @param[in]  aFlags        Flags modifying the behavior of this function,
   *                           see enum #SetFieldFlags.
   *
   * @return rc_ok if successful.
   *
   * @see getField(), removeField(), setField(), setTextFieldAttributes()
   */
  virtual ReturnCode addField (SignDocField &aField,
                               unsigned aFlags) = 0;

  /**
   * @brief Remove a field.
   *
   * Removing a field of a TIFF document will invalidate all signatures.
   *
   * @param[in]  aEncoding    The encoding of @a aName.
   * @param[in]  aName    The fully-qualified name of the field.
   *
   * @return rc_ok if successful.
   *
   * @see addField(), flattenField(), getFields()
   */
  virtual ReturnCode removeField (de::softpro::doc::Encoding aEncoding,
                                  const std::string &aName) = 0;

  /**
   * @brief Flatten a field.
   *
   * Flattening a field of a PDF document makes its appearance part of
   * the page and removes the selected widget or all widgets; the field
   * will be removed when all its widgets have been flattened.
   *
   * Flattening unsigned signature fields does not work correctly.
   *
   * @param[in]  aEncoding    The encoding of @a aName.
   * @param[in]  aName        The fully-qualified name of the field.
   * @param[in]  aWidget      The widget index to flatten only one widget
   *                          or -1 to flatten all widgets.
   *
   * @return rc_ok if successful.
   *
   * @see flattenFields(), removeField()
   */
  virtual ReturnCode flattenField (de::softpro::doc::Encoding aEncoding,
                                   const std::string &aName,
                                   int aWidget) = 0;

  /**
   * @brief Flatten all fields of the document or of a range of pages.
   *
   * Flattening a field of a PDF document makes its appearance part of
   * the page and removes the selected widget or all widgets; the field
   * will be removed when all its widgets have been flattened.
   * This function selects all widgets on the specified pages.
   *
   * Flattening unsigned signature fields does not work correctly.
   *
   * @param[in] aFirstPage  1-based number of first page.
   * @param[in] aLastPage   1-based number of last page or 0 to process
   *                        all pages to the end of the document.
   * @param[in] aFlags      Flags modifying the behavior of this function,
   *                        must be 0.
   *
   * @return rc_ok if successful.
   *
   * @see flattenField(), removeField()
   */
  virtual ReturnCode flattenFields (int aFirstPage, int aLastPage,
                                    unsigned aFlags) = 0;

  /**
   * @brief Export all fields as XML.
   *
   * This function always uses UTF-8 encoding.  The output conforms
   * to schema PdfFields.xsd.
   *
   * @param[in]  aStream  The fields will be saved to this stream.
   * @param[in]  aFlags   Flags modifying the behavior of this function,
   *                      See enum #ExportFlags.
   *
   * @return rc_ok if successful.
   *
   * @see getFields(), setField()
   *
   * @todo implement for TIFF
   */
  virtual ReturnCode exportFields (de::softpro::spooc::OutputStream &aStream,
                                   int aFlags) = 0;

  /**
   * @brief Apply an FDF document to a PDF document.
   *
   * FDF documents can be applied to PDF documents only.
   *
   * @param[in] aEncoding  The encoding of the string pointed to by @a aPath.
   * @param[in] aPath      The pathname of the FDF document.
   * @param[in] aFlags     Flags modifying the behavior of this function,
   *                       see enum #SetFieldFlags.
   *
   * @return rc_ok if successful.
   */
  virtual ReturnCode applyFdf (de::softpro::doc::Encoding aEncoding,
                               const char *aPath, unsigned aFlags) = 0;

  /**
   * @brief Apply an FDF document to a PDF document.
   *
   * FDF documents can be applied to PDF documents only.
   *
   * @param[in] aPath      The pathname of the FDF document.
   * @param[in] aFlags     Flags modifying the behavior of this function,
   *                       see enum #SetFieldFlags.
   *
   * @return rc_ok if successful.
   */
  virtual ReturnCode applyFdf (const wchar_t *aPath, unsigned aFlags) = 0;

  /**
   * @brief Get the document's default text field attributes.
   *
   * @param[in,out] aOutput  This object will be updated.
   *
   * @return rc_ok if successful.
   *
   * @see getField(), setTextFieldAttributes(), SignDocField::getTextFieldAttributes()
   */
  virtual ReturnCode getTextFieldAttributes (SignDocTextFieldAttributes &aOutput) = 0;

  /**
   * @brief Set the document's default text field attributes.
   *
   * Font name, font size, and text color must be specified.
   * This function fails if @a aData has any but not all attributes set
   * or if any of the attributes are invalid.
   *
   * This function fails for signed PDF document.
   *
   * This function always fails for TIFF documents.
   *
   * @param[in,out] aData  The new default text field attributes.
   *                       The font resource name will be updated.
   *
   * @return rc_ok iff successful.
   *
   * @see addField(), getTextFieldAttributes(), SignDocField::setTextFieldAttributes()
   */
  virtual ReturnCode setTextFieldAttributes (SignDocTextFieldAttributes &aData) = 0;

  /**
   * @brief Get the names and types of all SignDoc properties of a
   *        certain collection of properties of the document.
   *
   * Use getBooleanProperty(), getIntegerProperty(), or
   * getStringProperty() to get the values of the
   * properties. Documents supporting a SignDoc data block store
   * properties in the SignDoc data block.
   *
   * There are three collections of SignDoc document properties:
   * - "encrypted"   Encrypted properties. Names and values are symmetrically
   *                 encrypted.
   * - "public"      Public properties. Document viewer applications may
   *                 be able to display or let the user modify these
   *                 properties.
   * - "pdfa"        PDF/A properties (PDF documents only):
   *                 - part (PDF/A version identifier)
   *                 - amd (optional PDF/A amendment identifier)
   *                 - conformance (PDF/A conformance level: A or B)
   *                 .
   *                 All properties in this collection have string values,
   *                 the property names are case-sensitive.
   *                 If the "part" property is present, the document claims
   *                 to be conforming to PDF/A. Your application may change
   *                 its behavior when dealing with PDF/A documents. For
   *                 instance, it might want to avoid transparency.
   * .
   *
   * Using the same property name in the "encrypted" and "public"
   * collections is not possible. Attempts to get, set, or remove a
   * property in the wrong collection will fail with error code
   * rc_wrong_collection.  To move a property from one collection to
   * another collection, first remove it from the source collection,
   * then add it to the target collection.
   *
   * The "pdfa" collection is read-only and a property name existing
   * in that collection does not prevent that property name from
   * appearing in one of the other collections.
   *
   * The syntax of property names depends on the document type and the
   * collection containing the property.
   *
   * "public" properties of PDF documents are stored according to XMP in
   * namespace "http://www.softpro.de/pdfa/signdoc/public/", therefore
   * property names must be valid unqualified XML names, see the syntax
   * of "Name" in the XML 1.1 specification at
   * http://www.w3.org/TR/2004/REC-xml11-20040204/#sec-common-syn
   * (section 2.3 Common Syntactic Constructs).
   *
   * For "encrypted" properties and any properties in TIFF documents,
   * property names can contain arbitrary Unicode characters except for
   * NUL.
   *
   * @param[in] aCollection   The name of the collection, see above.
   * @param[out] aOutput  The properties will be stored here.
   *
   * @return rc_ok if successful.
   *
   * @see removeProperty(), getStringProperty(), getDataBlock()
   */
  virtual ReturnCode getProperties (const std::string &aCollection,
                                    std::vector<SignDocProperty> &aOutput) = 0;

  /**
   * @brief Get the value of a SignDoc property (integer).
   *
   * In the "public" and "encrypted" collections, property names are
   * compared under Unicode simple case folding, that is, lower case
   * and upper case is not distinguished.
   *
   * @param[in]  aEncoding   The encoding of @a aName.
   * @param[in]  aCollection   The name of the collection, see getProperties().
   * @param[in]  aName   The name of the property.
   * @param[out] aValue  The value will be stored here.
   *
   * @return rc_ok if successful.
   *
   * @see getBooleanProperty(), getProperties(), getStringProperty()
   */
  virtual ReturnCode getIntegerProperty (de::softpro::doc::Encoding aEncoding,
                                         const std::string &aCollection,
                                         const std::string &aName, long &aValue) = 0;

  /**
   * @brief Get the value of a SignDoc property (string).
   *
   * In the "public" and "encrypted" collections, property names are
   * compared under Unicode simple case folding, that is, lower case
   * and upper case is not distinguished.
   *
   * @param[in]  aEncoding   The encoding of @a aName and for @a aValue.
   * @param[in]  aCollection   The name of the collection, see getProperties().
   * @param[in]  aName   The name of the property.
   * @param[out] aValue  The value will be stored here, encoded according to
   *                     @a aEncoding.
   *
   * @return rc_ok if successful.
   *
   * @see getBooleanPropery(), getIntegerProperty(), getProperties()
   */
  virtual ReturnCode getStringProperty (de::softpro::doc::Encoding aEncoding,
                                        const std::string &aCollection,
                                        const std::string &aName, std::string &aValue) = 0;

  /**
   * @brief Get the value of a SignDoc property (boolean).
   *
   * In the "public" and "encrypted" collections, property names are
   * compared under Unicode simple case folding, that is, lower case
   * and upper case is not distinguished.
   *
   * @param[in]  aEncoding   The encoding of @a aName.
   * @param[in]  aCollection   The name of the collection, see getProperties().
   * @param[in]  aName   The name of the property.
   * @param[out] aValue  The value will be stored here.
   *
   * @return rc_ok if successful.
   *
   * @see getIntegerProperty(), getProperties(), getStringProperty()
   */
  virtual ReturnCode getBooleanProperty (de::softpro::doc::Encoding aEncoding,
                                         const std::string &aCollection,
                                         const std::string &aName, bool &aValue) = 0;

  /**
   * @brief Set the value of a SignDoc property (integer).
   *
   * In the "public" and "encrypted" collections, property names are
   * compared under Unicode simple case folding, that is, lower case
   * and upper case is not distinguished.
   *
   * It's not possible to change the type of a property.
   *
   * @param[in]  aEncoding   The encoding of @a aName.
   * @param[in]  aCollection   The name of the collection, see getProperties().
   * @param[in]  aName   The name of the property.
   * @param[in]  aValue  The new value of the property.
   *
   * @return rc_ok if successful.
   *
   * @see getProperties(), removeProperty(), setBooleanProperty(), setStringProperty(), addSignature()
   */
  virtual ReturnCode setIntegerProperty (de::softpro::doc::Encoding aEncoding,
                                         const std::string &aCollection,
                                         const std::string &aName, long aValue) = 0;

  /**
   * @brief Set the value of a SignDoc property (string).
   *
   * In the "public" and "encrypted" collections, property names are
   * compared under Unicode simple case folding, that is, lower case
   * and upper case is not distinguished.
   *
   * It's not possible to change the type of a property.
   * Embedded NUL characters are not supported.
   *
   * @param[in]  aEncoding   The encoding of @a aName and @a aValue.
   * @param[in]  aCollection   The name of the collection, see getProperties().
   * @param[in]  aName   The name of the property.
   * @param[in]  aValue  The new value of the property.
   *
   * @return rc_ok if successful.
   *
   * @see getProperties(), removeProperty(), setBooleanProperty(), setIntegerProperty(), addSignature()
   */
  virtual ReturnCode setStringProperty (de::softpro::doc::Encoding aEncoding,
                                        const std::string &aCollection,
                                        const std::string &aName,
                                        const std::string &aValue) = 0;

  /**
   * @brief Set the value of a SignDoc property (boolean).
   *
   * In the "public" and "encrypted" collections, property names are
   * compared under Unicode simple case folding, that is, lower case
   * and upper case is not distinguished.
   *
   * It's not possible to change the type of a property.
   *
   * @param[in]  aEncoding   The encoding of @a aName.
   * @param[in]  aCollection   The name of the collection, see getProperties().
   * @param[in]  aName   The name of the property.
   * @param[in]  aValue  The new value of the property.
   *
   * @return rc_ok if successful.
   *
   * @see getProperties(), removeProperty(), setIntegerProperty(), setStringProperty(), addSignature()
   */
  virtual ReturnCode setBooleanProperty (de::softpro::doc::Encoding aEncoding,
                                         const std::string &aCollection,
                                         const std::string &aName, bool aValue) = 0;

  /**
   * @brief Remove a SignDoc property.
   *
   * In the "public" and "encrypted" collections, property names are
   * compared under Unicode simple case folding, that is, lower case
   * and upper case is not distinguished.
   *
   * @param[in]  aEncoding   The encoding of @a aName.
   * @param[in]  aCollection   The name of the collection, see getProperties().
   * @param[in]  aName   The name of the property.
   *
   * @return rc_ok if successful.
   *
   * @see getProperties(), setStringProperty()
   */
  virtual ReturnCode removeProperty (de::softpro::doc::Encoding aEncoding,
                                     const std::string &aCollection,
                                     const std::string &aName) = 0;

  /**
   * @brief Export properties as XML.
   *
   * This function always uses UTF-8 encoding.
   * The output conforms to schema AllSignDocProperties.xsd
   * (if @a aCollection is empty) or SignDocProperties.xsd
   * (if @a aCollection is non-empty).
   *
   * @param[in]  aCollection   The name of the collection, see getProperties().
   *                           If the string is empty, all properties of the
   *                           "public" and "encrypted" collections
   *                           will be exported.
   * @param[in]  aStream  The properties will be saved to this stream.
   * @param[in]  aFlags   Flags modifying the behavior of this function,
   *                      See enum #ExportFlags.
   *
   * @return rc_ok if successful.
   *
   * @see importProperties()
   */
  virtual ReturnCode exportProperties (const std::string &aCollection,
                                       de::softpro::spooc::OutputStream &aStream,
                                       int aFlags) = 0;

  /**
   * @brief Import properties from XML.
   *
   * The input must conform to schema AllSignDocProperties.xsd
   * (if @a aCollection is empty) or SignDocProperties.xsd
   * (if @a aCollection is non-empty).
   *
   * @param[in]  aCollection   The name of the collection, see getProperties().
   *                           If the string is empty, properties will be
   *                           imported into all collections, otherwise
   *                           properties will be imported into the specified
   *                           collection.
   * @param[in]  aStream  The properties will be read from this stream.
   *                      This function reads the input completely, it doesn't
   *                      stop at the end tag.
   * @param[in]  aFlags   Flags modifying the behavior of this function,
   *                      See enum #ImportFlags.
   *
   * @return rc_ok if successful.
   *
   * @see exportProperties()
   */
  virtual ReturnCode importProperties (const std::string &aCollection,
                                       de::softpro::spooc::InputStream &aStream,
                                       int aFlags) = 0;

  /**
   * @brief Get the SignDoc data block of the document.
   *
   * @param[out]  aOutput  The serialized data block will be copied to
   *                       this object.
   *
   * @return rc_ok if successful, rc_no_datablock if there is no SignDoc
   *         data block, rc_not_supported if the document type does not
   *         support a SignDoc data block.
   *
   * @see setDataBlock(), getProperties()
   */
  virtual ReturnCode getDataBlock (std::vector<unsigned char> &aOutput) = 0;

  /**
   * @brief Replace the SignDoc data block of the document.
   *
   * This function discards properties set with
   * setStringProperty() etc., including unsaved changes.
   *
   * @param[in] aData  Pointer to the first octet of the serialized data
   *                   block.
   * @param[in] aSize  Size of the serialized data block (number of octets).
   *
   * @return rc_ok if successful, rc_not_supported if the document type does
   *         not support a SignDoc data block.
   *
   * @see getDataBlock()
   */
  virtual ReturnCode setDataBlock (const unsigned char *aData,
                                   size_t aSize) = 0;

  /**
   * @brief Get the resolution of a page.
   *
   * Different pages of the document may have different resolutions.
   * Use getConversionFactors() to get factors for converting document
   * coordinates to real world coordinates.
   *
   * @param[in]  aPage    The page number (1 for the first page).
   * @param[out] aResX    The horizontal resolution in DPI will be stored here.
   *                      The value will be 0.0 if the resolution is not
   *                      available.
   * @param[out] aResY    The vertical resolution in DPI will be stored here.
   *                      The value will be 0.0 if the resolution is not
   *                      available.
   *
   * @return rc_ok if successful.
   *
   * @see getConversionFactors()
   */
  virtual ReturnCode getResolution (int aPage, double &aResX, double &aResY) = 0;

  /**
   * @brief Get the conversion factors for a page.
   *
   * Different pages of the document may have different conversion factors.
   * For TIFF documents, this function yields the same values as
   * getResolution().
   *
   * @param[in]  aPage    The page number (1 for the first page).
   * @param[out] aFactorX    Divide horizontal coordinates by this number
   *                         to convert document coordinates to inches.
   *                         The value will be 0.0 if the conversion factor
   *                         is not available.
   * @param[out] aFactorY    Divide vertical coordinates by this number
   *                         to convert document coordinates to inches.
   *                         The value will be 0.0 if the conversion factor
   *                         is not available.
   *
   * @return rc_ok if successful.
   *
   * @see getPageSize(), getResolution()
   */
  virtual ReturnCode getConversionFactors (int aPage, double &aFactorX,
                                           double &aFactorY) = 0;

  /**
   * @brief Get the size of a page.
   *
   * Different pages of the document may have different sizes.
   * Use getConversionFactors() to get factors for converting the page size
   * from document coordinates to real world dimensions.
   *
   * @param[in]  aPage    The page number (1 for the first page).
   * @param[out] aWidth   The width of the page (in document coordinates)
   *                      will be stored here.
   * @param[out] aHeight  The height of the page (in document coordinates)
   *                      will be stored here.
   *
   * @return rc_ok if successful.
   *
   * @see getConversionFactors()
   */
  virtual ReturnCode getPageSize (int aPage, double &aWidth, double &aHeight) = 0;

  /**
   * @brief Get the number of bits per pixel (TIFF only).
   *
   * Different pages of the document may have different numbers of bits
   * per pixel.
   *
   * @param[in]  aPage    The page number (1 for the first page).
   * @param[out] aBPP     The number of bits per pixel of the page
   *                      (1, 8, 24, or 32) or 0 (for PDF documents)
   *                      will be stored here.
   *
   * @return rc_ok if successful, rc_invalid_argument if @a aPage is
   *         out of range.
   */
  virtual ReturnCode getBitsPerPixel (int aPage, int &aBPP) = 0;

  /**
   * @brief Compute the zoom factor used for rendering.
   *
   * If SignDocRenderParameters::fitWidth(),
   * SignDocRenderParameters::fitHeight(), or
   * SignDocRenderParameters::fitRect() has been called, the actual factor
   * depends on the document's page size.
   * If multiple pages are selected (see #SignDocRenderParameters::setPages()),
   * the maximum width and maximum height of all selected pages will be used.
   *
   * @param[out] aOutput  The zoom factor will be stored here.
   * @param[in]  aParams  The parameters such as the page number and the
   *                      zoom factor.
   *
   * @return rc_ok if successful.
   *
   * @see getRenderedSize(), renderPageAsImage(), SignDocRenderParameters::fitHeight(), SignDocRenderParameters::fitRect(), SignDocRenderParameters::fitWidth(), SignDocRenderParameters::setPages(), SignDocRenderParameters::setZoom()
   */
  virtual ReturnCode computeZoom (double &aOutput,
                                  const SignDocRenderParameters &aParams) = 0;

  /**
   * @brief Convert a point expressed in canvas (image) coordinates to
   *        a point expressed in document coordinate system of the
   *        current page.
   *
   * The origin is in the bottom left corner of the page.
   * The origin is in the upper left corner of the image.
   * See @ref signdocshared_coordinates.
   * If multiple pages are selected (see #SignDocRenderParameters::setPages()),
   * the first page of the range will be used.
   *
   * @param[in,out] aPoint   The point to be converted.
   * @param[in]     aParams  The parameters such as the page number and the
   *                         zoom factor.
   *
   * @return rc_ok if successful.
   */
  virtual ReturnCode convCanvasPointToPagePoint (de::softpro::doc::Point &aPoint,
                                                 const SignDocRenderParameters &aParams) = 0;

  /**
   * @brief Convert a point expressed in document coordinate system of the
   *        current page to a point expressed in canvas (image) coordinates.
   *
   * The origin is in the bottom left corner of the page.
   * The origin is in the upper left corner of the image.
   * See @ref signdocshared_coordinates.
   * If multiple pages are selected (see #SignDocRenderParameters::setPages()),
   * the first page of the range will be used.
   *
   * @param[in,out] aPoint   The point to be converted.
   * @param[in]     aParams  The parameters such as the page number and the
   *                         zoom factor.
   *
   * @return rc_ok if successful.
   */
  virtual ReturnCode convPagePointToCanvasPoint (de::softpro::doc::Point &aPoint,
                                                 const SignDocRenderParameters &aParams) = 0;

  /**
   * @brief Render the selected page (or pages) as image.
   *
   *
   * @param[out] aImage  The image will be stored here as a blob.
   * @param[out] aOutput The image size will be stored here.
   * @param[in]  aParams    Parameters such as the page number.
   * @param[in]  aClipRect  The rectangle to be rendered (using document
   *                        coordinates, see @ref signdocshared_coordinates)
   *                        or NULL to render the complete page.
   *
   * @return rc_ok if successful.
   *
   * @see computeZoom(), getRenderedSize(), renderPageAsSpoocImage(), renderPageAsSpoocImages()
   */
  virtual ReturnCode renderPageAsImage (std::vector<unsigned char> &aImage,
                                        SignDocRenderOutput &aOutput,
                                        const SignDocRenderParameters &aParams,
                                        const de::softpro::doc::Rect *aClipRect) = 0;

  /**
   * @brief Render the selected page to a spooc image.
   *
   * @param[in,out] aImage   This object will be updated to contain
   *                         the desired image.
   * @param[out] aOutput  The image size will be stored here.
   * @param[in]  aParams    Parameters such as the page number.
   *                        There must be exactly one page selected.
   * @param[in]  aClipRect  The rectangle to be rendered (using document
   *                        coordinates, see @ref signdocshared_coordinates)
   *                        or NULL to render the complete page.
   *
   * @return rc_ok if successful.
   *
   * @see computeZoom(), getRenderedSize(), renderPageAsImage(), renderPageAsSpoocImages()
   *
   * @todo improve documentation
   */
  virtual ReturnCode renderPageAsSpoocImage (de::softpro::spooc::Image &aImage,
                                             SignDocRenderOutput &aOutput,
                                             const SignDocRenderParameters &aParams,
                                             const de::softpro::doc::Rect *aClipRect) = 0;

  /**
   * @brief Render the selected page (or pages) to a spooc multi-page image.
   *
   * @param[in,out] aImages  This object will be updated to contain
   *                         the desired images.
   * @param[out] aOutput  The image size will be stored here.
   * @param[in]  aParams    Parameters such as the page number.
   * @param[in]  aClipRect  The rectangle to be rendered (using document
   *                        coordinates, see @ref signdocshared_coordinates)
   *                        or NULL to render the complete page.
   *
   * @return rc_ok if successful.
   *
   * @see computeZoom(), getRenderedSize(), renderPageAsImage(), renderPageAsSpoocImage()
   *
   * @todo improve documentation
   */
  virtual ReturnCode renderPageAsSpoocImages (de::softpro::spooc::Images &aImages,
                                              SignDocRenderOutput &aOutput,
                                              const SignDocRenderParameters &aParams,
                                              const de::softpro::doc::Rect *aClipRect) = 0;

  /**
   * @brief Get the size of the rendered page in pixels (without actually
   *        rendering it).
   *
   * The returned values may be approximations for some document formats.
   * If multiple pages are selected (see #SignDocRenderParameters::setPages()),
   * the maximum width and maximum height of all selected pages will be used.
   *
   * @param[out] aOutput   The width and height of the image that would be
   *                       computed by renderPageAsImage() with @a aClipRect
   *                       being NULL will be stored here.
   * @param[in]  aParams   Parameters such as the page number.
   *
   * @return rc_ok if successful.
   *
   * @see renderPageAsImage(), renderPageAsSpoocImage(), renderPageAsSpoocImages()
   */
  virtual ReturnCode getRenderedSize (SignDocRenderOutput &aOutput,
                                      const SignDocRenderParameters &aParams) = 0;

  /**
   * @brief Create a line annotation.
   *
   * See SignDocAnnotation for details.
   *
   * This function uses document (page) coordinates,
   * see @ref signdocshared_coordinates.
   *
   * @param[in]  aStart    Start point.
   * @param[in]  aEnd      End point.
   *
   * @return The new annotation object. The caller is responsible for
   *         destroying the object after use.
   *
   * @see addAnnotation()
   */
  virtual SignDocAnnotation *createLineAnnotation (const de::softpro::doc::Point &aStart,
                                                   const de::softpro::doc::Point &aEnd) = 0;

  /**
   * @brief Create a line annotation.
   *
   * See SignDocAnnotation for details.
   * This function uses document (page) coordinates,
   * see @ref signdocshared_coordinates.
   *
   * @param[in]  aStartX   X coordinate of start point.
   * @param[in]  aStartY   Y coordinate of start point.
   * @param[in]  aEndX     X coordinate of end point.
   * @param[in]  aEndY     Y coordinate of end point.
   *
   * @return The new annotation object. The caller is responsible for
   *         destroying the object after use.
   *
   * @see addAnnotation()
   */
  virtual SignDocAnnotation *createLineAnnotation (double aStartX, double aStartY,
                                                   double aEndX, double aEndY) = 0;

  /**
   * @brief Create a scribble annotation.
   *
   * See SignDocAnnotation for details.
   * This function uses document (page) coordinates,
   * see @ref signdocshared_coordinates.
   *
   * @return The new annotation object. The caller is responsible for
   *         destroying the object after use.
   *
   * @see addAnnotation(), SignDocAnnotation::addPoint(), SignDocAnnotation::newStroke()
   */
  virtual SignDocAnnotation *createScribbleAnnotation () = 0;

  /**
   * @brief Create a text annotation.
   *
   * See SignDocAnnotation for details.
   * This function uses document (page) coordinates,
   * see @ref signdocshared_coordinates.
   *
   * @param[in]  aLowerLeft  coordinates of lower left corner.
   * @param[in]  aUpperRight coordinates of upper right corner.
   *
   * @return The new annotation object. The caller is responsible for
   *         destroying the object after use.
   *
   * @see addAnnotation()
   */
  virtual SignDocAnnotation *createFreeTextAnnotation (const de::softpro::doc::Point &aLowerLeft,
                                                       const de::softpro::doc::Point &aUpperRight) = 0;

  /**
   * @brief Create a text annotation.
   *
   * See SignDocAnnotation for details.
   * This function uses document (page) coordinates,
   * see @ref signdocshared_coordinates.
   *
   * @param[in]  aX0       X coordinate of lower left corner.
   * @param[in]  aY0       Y coordinate of lower left corner.
   * @param[in]  aX1       X coordinate of upper right corner.
   * @param[in]  aY1       Y coordinate of upper right corner.
   *
   * @return The new annotation object. The caller is responsible for
   *         destroying the object after use.
   *
   * @see addAnnotation()
   */
  virtual SignDocAnnotation *createFreeTextAnnotation (double aX0, double aY0,
                                                       double aX1, double aY1) = 0;

  /**
   * @brief Add an annotation to a page.
   *
   * See SignDocAnnotation for details.
   *
   * @param[in]  aPage     The page number (1 for the first page).
   * @param[in]  aAnnot    Pointer to the new annotation.  Ownership remains
   *                       at the caller.
   *
   * @return rc_ok if successful.
   *
   * @see createLineAnnotation(), createScribbleAnnotation(), createFreeTextAnnotation()
   */
  virtual ReturnCode addAnnotation (int aPage, const SignDocAnnotation *aAnnot) = 0;

  /**
   * @brief Get a list of all named annotations of a page.
   *
   * Unnamed annotations are ignored by this function.
   *
   * @param[in]  aEncoding  The encoding to be used for the names of the
   *                        annotations returned in @a aOutput.
   * @param[in]  aPage     The page number (1 for the first page).
   * @param[out] aOutput   The names of the annotations will be stored here.
   *
   * @return rc_ok if successful.
   *
   * @see addAnnotation(), getAnnotation(), removeAnnotation(), SignDocAnnotation::setName()
   */
  virtual ReturnCode getAnnotations (de::softpro::doc::Encoding aEncoding,
                                     int aPage, std::vector<std::string> &aOutput) = 0;

  /**
   * @brief Get a named annotation of a page.
   *
   * All setters will fail for the returned object.
   *
   * @param[in]  aEncoding   The encoding of @a aName.
   * @param[in]  aPage     The page number (1 for the first page).
   * @param[in]  aName     The name of the annotation.
   * @param[out] aOutput   A pointer to a new SignDocAnnotation object or
   *                       NULL will be stored here. The caller is responsible
   *                       for destroying that object.
   *
   * @return rc_ok if successful.
   *
   * @see getAnnotations()
   */
  virtual ReturnCode getAnnotation (de::softpro::doc::Encoding aEncoding,
                                    int aPage, const std::string &aName,
                                    SignDocAnnotation *&aOutput) = 0;

  /**
   * @brief Remove an annotation identified by name.
   *
   * @param[in]  aEncoding   The encoding of @a aName.
   * @param[in]  aPage     The page number (1 for the first page).
   * @param[in]  aName     The name of the annotation, must not be
   *                       empty.
   *
   * @return rc_ok if successful.
   *
   * @see addAnnotation(), getAnnotations(), SignDocAnnotation::setName()
   */
  virtual ReturnCode removeAnnotation (de::softpro::doc::Encoding aEncoding,
                                       int aPage, const std::string &aName) = 0;

  /**
   * @brief Add text to a page.
   *
   * Multiple lines are not supported, the text must not contain CR
   * and LF characters.
   *
   * @param[in] aEncoding   The encoding of @a aText and @a aFontName.
   * @param[in] aText       The text. Complex scripts are supported,
   *                        see @ref signdocshared_complex_scripts.
   * @param[in] aPage       The 1-based page number of the page.
   * @param[in] aX          The X coordinate of the reference point of
   *                        the first character in document coordinates.
   * @param[in] aY          The Y coordinate of the reference point of
   *                        the first character in document coordinates.
   * @param[in] aFontName   The font name.
   *                        This can be the name of a standard font,
   *                        the name of an already embedded font, or
   *                        the name of a font defined by a font
   *                        configuration file.
   * @param[in] aFontSize   The font size (in user space units).
   * @param[in] aTextColor  The text color.
   * @param[in] aOpacity    The opacity, 0.0 (transparent) through 1.0 (opaque).
   *                        Documents conforming to PDF/A must use an opacity
   *                        of 1.0.
   * @param[in] aFlags      Must be 0.
   *
   * @see addTextRect(), addWatermark(), SignDocDocumentLoader::loadFontConfigFile(), SignDocDocumentLoader::loadFontConfigEnvironment(), SignDocDocumentLoader::loadFontConfigStream()
   *
   * @todo implement for TIFF documents
   */
  virtual ReturnCode addText (de::softpro::doc::Encoding aEncoding,
                              const std::string &aText, int aPage,
                              double aX, double aY,
                              const std::string &aFontName, double aFontSize,
                              const SignDocColor &aTextColor,
                              double aOpacity, int aFlags) = 0;

  /**
   * @brief Add text in a rectangle of a page (with line breaking).
   *
   * Any sequence of CR and LF characters in the text starts a new
   * paragraph (ie, text following such a sequence will be placed at
   * the beginning of the next output line). In consequence, empty
   * lines in the input do not produce empty lines in the output. To
   * get an empty line in the output, you have to add a paragraph
   * containing a non-breaking space (0xa0) only:
   * @code
   * "Line before empty line\n\xa0\nLine after empty line"
   * @endcode
   *
   * @note This function does not yet support complex scripts.
   *
   * @param[in] aEncoding   The encoding of @a aText and @a aFontName.
   * @param[in] aText       The text. Allowed control characters are
   *                        CR and LF. Any sequence of CR and LF characters
   *                        starts a new paragraph.
   * @param[in] aPage       The 1-based page number of the page.
   * @param[in] aX0         X coordinate of lower left corner.
   * @param[in] aY0         Y coordinate of lower left corner.
   * @param[in] aX1         X coordinate of upper right corner.
   * @param[in] aY1         Y coordinate of upper right corner.
   * @param[in] aFontName   The font name.
   *                        This can be the name of a standard font,
   *                        the name of an already embedded font, or
   *                        the name of a font defined by a font
   *                        configuration file.
   * @param[in] aFontSize   The font size (in user space units).
   * @param[in] aLineSkip   The vertical distance between the baselines of
   *                        successive lines (usually 1.2 * aFontSize).
   * @param[in] aTextColor  The text color.
   * @param[in] aOpacity    The opacity, 0.0 (transparent) through 1.0 (opaque).
   *                        Documents conforming to PDF/A must use an opacity
   *                        of 1.0.
   * @param[in] aHAlignment Horizontal alignment of the text.
   * @param[in] aVAlignment Vertical alignment of the text.
   * @param[in] aFlags      Must be 0.
   *
   * @see addText(), addWatermark(), SignDocDocumentLoader::loadFontConfigFile(), SignDocDocumentLoader::loadFontConfigEnvironment(), SignDocDocumentLoader::loadFontConfigStream()
   *
   * @todo implement for TIFF documents
   */
  virtual ReturnCode addTextRect (de::softpro::doc::Encoding aEncoding,
                                  const std::string &aText, int aPage,
                                  double aX0, double aY0,
                                  double aX1, double aY1,
                                  const std::string &aFontName,
                                  double aFontSize, double aLineSkip,
                                  const SignDocColor &aTextColor,
                                  double aOpacity, HAlignment aHAlignment,
                                  VAlignment aVAlignment,
                                  int aFlags) = 0;

  /**
   * @brief Add a watermark.
   *
   * @param[in] aInput   An object describing the watermark.
   *
   * @see addText(), addTextRect(), SignDocDocumentLoader::loadFontConfigFile(), SignDocDocumentLoader::loadFontConfigEnvironment(), SignDocDocumentLoader::loadFontConfigStream()
   *
   * @todo implement for TIFF documents
   */
  virtual ReturnCode addWatermark (const SignDocWatermark &aInput) = 0;

  /**
   * @brief Find text.
   *
   * @param[in] aEncoding   The encoding of @a aText.
   * @param[in] aFirstPage  1-based number of first page to be searched.
   * @param[in] aLastPage   1-based number of last page to be searched or
   *                        0 to search to the end of the document.
   * @param[in] aText       Text to be searched for.
   *                        Multiple successive spaces are treated as
   *                        single space (and may be ignored subject to
   *                        @a aFlags).
   * @param[in] aFlags      Flags modifying the behavior of this function,
   *                        see enum #FindTextFlags.
   * @param[out] aOutput    The positions where @a aText was found.
   *
   * @return rc_ok on success (even if the text was not found).
   */
  virtual ReturnCode findText (de::softpro::doc::Encoding aEncoding,
                               int aFirstPage, int aLastPage,
                               const std::string &aText, int aFlags,
                               std::vector<SignDocFindTextPosition> &aOutput) = 0;

  /**
   * @brief Add an attachment to the document.
   *
   * Attachments are supported for PDF documents only.
   *
   * @param[in]  aEncoding       The encoding of @a aName and @a aDescription.
   * @param[in]  aName           The name of the attachment. Will also be
   *                             used as filename of the attachment and must
   *                             not contain slashes, backslashes, and colons.
   * @param[in]  aDescription    The description of the attachment (can be
   *                             empty).
   * @param[in]  aType           The MIME type of the attachment (can be
   *                             empty, seems to be ignored by Adobe Reader).
   * @param[in]  aModificationTime    The time and date of the last
   *                             modification of the file being attached
   *                             to the document (can be empty).  Must be
   *                             in ISO 8601 extended calendar date format
   *                             with optional timezone.
   * @param[in]  aPtr            Pointer to the first octet of the attachment.
   * @param[in]  aSize           The size (in octets) of the attachment.
   * @param[in]  aFlags          Must be zero.
   *
   * @return rc_ok if successful.
   *
   * @see addAttachmentFile(), getAttachments(), removeAttachment()
   */
  virtual ReturnCode addAttachmentBlob (de::softpro::doc::Encoding aEncoding,
                                        const std::string &aName,
                                        const std::string &aDescription,
                                        const std::string &aType,
                                        const std::string &aModificationTime,
                                        const void *aPtr, size_t aSize,
                                        int aFlags) = 0;

  /**
   * @brief Add an attachment (read from a file) to the document.
   *
   * Attachments are supported for PDF documents only.
   *
   * @param[in]  aEncoding1      The encoding of @a aName and @a aDescription.
   * @param[in]  aName           The name of the attachment. Will also be
   *                             used as filename of the attachment and must
   *                             not contain slashes, backslashes, and colons.
   * @param[in]  aDescription    The description of the attachment (can be
   *                             empty).
   * @param[in]  aType           The MIME type of the attachment (can be
   *                             empty, seems to be ignored by Adobe Reader).
   * @param[in]  aEncoding2      The encoding of @a aPath.
   * @param[in]  aPath           The pathname of the file to be attached.
   * @param[in]  aFlags          Must be zero.
   *
   * @return rc_ok if successful.
   *
   * @see addAttachmentBlob(), getAttachments(), removeAttachment()
   */
  virtual ReturnCode addAttachmentFile (de::softpro::doc::Encoding aEncoding1,
                                        const std::string &aName,
                                        const std::string &aDescription,
                                        const std::string &aType,
                                        de::softpro::doc::Encoding aEncoding2,
                                        const std::string &aPath,
                                        int aFlags) = 0;

  /**
   * @brief Remove an attachment from the document.
   *
   * Attachments are supported for PDF documents only.
   *
   * @param[in]  aEncoding       The encoding of @a aName and @a aDescription.
   * @param[in]  aName           The name of the attachment.
   *
   * @return rc_ok if successful.
   *
   * @see addAttachmentBlob(), addAttachmentFile(), getAttachments()
   */
  virtual ReturnCode removeAttachment (de::softpro::doc::Encoding aEncoding,
                                        const std::string &aName) = 0;

  /**
   * @brief Change the description of an attachment of the document.
   *
   * Attachments are supported for PDF documents only.
   *
   * @param[in]  aEncoding       The encoding of @a aName and @a aDescription.
   * @param[in]  aName           The name of the attachment.
   * @param[in]  aDescription    The new description of the attachment.
   *
   * @return rc_ok if successful.
   *
   * @see addAttachmentBlob(), addAttachmentFile(), getAttachments(), removeAttachment()
   */
  virtual ReturnCode changeAttachmentDescription (de::softpro::doc::Encoding aEncoding,
                                                  const std::string &aName,
                                                  const std::string &aDescription) = 0;

  /**
   * @brief Get a list of all attachments of the document.
   *
   * Attachments are supported for PDF documents only.
   *
   * @param[in]  aEncoding  The encoding to be used for the names returned
   *                        in @a aOutput.
   * @param[out] aOutput    The names of the document's attachments
   *                        will be stored here.  Use getAttachment()
   *                        to get information for a single attachment.
   *
   * @return rc_ok if successful.
   *
   * @see checkAttachment(), getAttachment(), getAttachmentBlob(), getAttachmentStream()
   */
  virtual ReturnCode getAttachments (de::softpro::doc::Encoding aEncoding,
                                     std::vector<std::string> &aOutput) = 0;

  /**
   * @brief Get information about an attachment.
   *
   * Attachments are supported for PDF documents only.
   *
   * @param[in]  aEncoding  The encoding of @a aName.
   * @param[in]  aName      The name of the attachment.
   * @param[out] aOutput    Information about the attachment will be stored
   *                        here.
   *
   * @return rc_ok if successful.
   *
   * @see checkAttachment(), getAttachments(), getAttachmentBlob(), getAttachmentStream()
   */
  virtual ReturnCode getAttachment (de::softpro::doc::Encoding aEncoding,
                                    const std::string &aName,
                                    SignDocAttachment &aOutput) = 0;

  /**
   * @brief Check the checksum of an attachment.
   *
   * Attachments are supported for PDF documents only.
   *
   * @param[in]  aEncoding  The encoding of @a aName.
   * @param[in]  aName      The name of the attachment.
   * @param[out] aOutput    The result of the check will be stored here.
   *
   * @return rc_ok if successful.
   *
   * @see getAttachment(), getAttachments(), getAttachmentBlob(), getAttachmentStream()
   */
  virtual ReturnCode checkAttachment (de::softpro::doc::Encoding aEncoding,
                                      const std::string &aName,
                                      CheckAttachmentResult &aOutput) = 0;

  /**
   * @brief Get an attachment as blob.
   *
   * Attachments are supported for PDF documents only.
   *
   * @param[in]  aEncoding  The encoding of @a aName.
   * @param[in]  aName      The name of the attachment.
   * @param[out] aOutput    The attachment will be stored here.
   *
   * @return rc_ok if successful.
   *
   * @see checkAttachment(), getAttachments(), getAttachmentStream()
   */
  virtual ReturnCode getAttachmentBlob (de::softpro::doc::Encoding aEncoding,
                                        const std::string &aName,
                                        std::vector<unsigned char> &aOutput) = 0;

  /**
   * @brief Get an InputStream for an attachment.
   *
   * Attachments are supported for PDF documents only.
   *
   * @param[in]  aEncoding  The encoding of @a aName.
   * @param[in]  aName      The name of the attachment.
   * @param[out] aOutput    A pointer to a new InputStream object will be
   *                        stored here; the caller is responsible for
   *                        deleting that object after use. The InputStream
   *                        does not support seek(), tell(), and avail().
   *
   * @return rc_ok if successful.
   *
   * @see checkAttachment(), getAttachments(), getAttachmentBlob()
   */
  virtual ReturnCode getAttachmentStream (de::softpro::doc::Encoding aEncoding,
                                          const std::string &aName,
                                          de::softpro::spooc::InputStream *&aOutput) = 0;

  /**
   * @brief Import pages from another document.
   *
   * This function is currently implemented for PDF documents only.
   * The pages to be imported must not contain any interactive fields
   * having names that are already used for intercative fields in the
   * target document.
   *
   * @param[in]  aTargetPage  The 1-based number of the page before which
   *                          to insert the copied pages.  The pages will
   *                          be appended if this value is 0.
   * @param[in]  aSource      The document from which to copy the pages.
   *                          @a aSource can be this.
   * @param[in]  aSourcePage  The 1-based number of the first page (in the
   *                          source document) to be copied.
   * @param[in]  aPageCount   The number of pages to be copied.  All pages
   *                          of @a aSource starting with @a aSourcePage
   *                          will be copied if this value is 0.
   * @param[in]  aFlags       Must be zero.
   *
   * @return rc_ok if successful.
   */
  virtual ReturnCode importPages (int aTargetPage, SignDocDocument *aSource,
                                  int aSourcePage, int aPageCount,
                                  int aFlags) = 0;

  /**
   * @brief Import a page from a blob containing an image.
   *
   * This function is currently implemented for PDF documents only.
   *
   * @param[in]  aTargetPage  The 1-based number of the page before which
   *                          to insert the new page.  The page will
   *                          be appended if this value is 0.
   * @param[in]  aPtr         Pointer to the first octet of the blob containing
   *                          the image.
   *                          Supported formats for inserting into PDF
   *                          documents are: JPEG, PNG, GIF, TIFF, and BMP.
   * @param[in]  aSize        Size (in octets) of the blob pointed to by
   *                          @a aPtr.
   * @param[in]  aZoom        Zoom factor or zero.  If this argument is
   *                          non-zero, @a aWidth and @a aHeight must be
   *                          zero.  The size of the page is computed from
   *                          the image size and resolution, multiplied by
   *                          @a aZoom.
   * @param[in]  aWidth       Page width (document coordinates) or zero.
   *                          If this argument is non-zero, @a aHeight must
   *                          also be non-zero and @a aZoom must be zero.
   *                          The image will be scaled to this width.
   * @param[in]  aHeight      Page height (document coordinates) or zero.
   *                          If this argument is non-zero, @a aWidth must
   *                          also be non-zero and @a aZoom must be zero.
   *                          The image will be scaled to this height.
   * @param[in]  aFlags       Flags modifying the behavior of this function,
   *                          See enum #ImportImageFlags.  ii_keep_aspect_ratio
   *                          is not needed if @a aZoom is non-zero.
   *
   * @return rc_ok if successful.
   *
   * @see addImageFromBlob(), importPageFromImageFile()
   *
   * @todo multi-page TIFF
   */
  virtual ReturnCode importPageFromImageBlob (int aTargetPage,
                                              const unsigned char *aPtr,
                                              size_t aSize, double aZoom,
                                              double aWidth, double aHeight,
                                              int aFlags) = 0;

  /**
   * @brief Import a page from a file containing an image.
   *
   * This function is currently implemented for PDF documents only.
   *
   * @param[in]  aTargetPage  The 1-based number of the page before which
   *                          to insert the new page.  The page will
   *                          be appended if this value is 0.
   * @param[in]  aEncoding    The encoding of @a aPath.
   * @param[in]  aPath        The pathname of the file containing the image.
   *                          Supported formats for inserting into PDF
   *                          documents are: JPEG, PNG, GIF, TIFF, and BMP.
   * @param[in]  aZoom        Zoom factor or zero.  If this argument is
   *                          non-zero, @a aWidth and @a aHeight must be
   *                          zero.  The size of the page is computed from
   *                          the image size and resolution, multiplied by
   *                          @a aZoom.
   * @param[in]  aWidth       Page width (document coordinates) or zero.
   *                          If this argument is non-zero, @a aHeight must
   *                          also be non-zero and @a aZoom must be zero.
   *                          The image will be scaled to this width.
   * @param[in]  aHeight      Page height (document coordinates) or zero.
   *                          If this argument is non-zero, @a aWidth must
   *                          also be non-zero and @a aZoom must be zero.
   *                          The image will be scaled to this height.
   * @param[in]  aFlags       Flags modifying the behavior of this function,
   *                          See enum #ImportImageFlags.  ii_keep_aspect_ratio
   *                          is not needed if @a aZoom is non-zero.
   *
   * @return rc_ok if successful.
   *
   * @see addImageFromFile(), importPageFromImageBlob()
   *
   * @todo multi-page TIFF
   */
  virtual ReturnCode importPageFromImageFile (int aTargetPage,
                                              de::softpro::doc::Encoding aEncoding,
                                              const std::string &aPath,
                                              double aZoom,
                                              double aWidth, double aHeight,
                                              int aFlags) = 0;

  /**
   * @brief Add an image (from a blob) to a page.
   *
   * @param[in]  aTargetPage  The 1-based number of the page.
   * @param[in]  aPtr         Pointer to the first octet of the blob containing
   *                          the image.
   *                          Supported formats for inserting into PDF
   *                          documents are: JPEG, PNG, GIF, TIFF, and BMP.
   * @param[in]  aSize        Size (in octets) of the blob pointed to by
   *                          @a aPtr.
   * @param[in]  aZoom        Zoom factor or zero.  If this argument is
   *                          non-zero, @a aWidth and @a aHeight must be
   *                          zero.  The size of the page is computed from
   *                          the image size and resolution, multiplied by
   *                          @a aZoom.
   * @param[in]  aX           The X coordinate of the point at which the
   *                          lower left corner of the image shall be placed.
   * @param[in]  aY           The Y coordinate of the point at which the
   *                          lower left corner of the image shall be placed.
   * @param[in]  aWidth       Image width (document coordinates) or zero.
   *                          If this argument is non-zero, @a aHeight must
   *                          also be non-zero and @a aZoom must be zero.
   *                          The image will be scaled to this width.
   * @param[in]  aHeight      Page height (document coordinates) or zero.
   *                          If this argument is non-zero, @a aWidth must
   *                          also be non-zero and @a aZoom must be zero.
   *                          The image will be scaled to this height.
   * @param[in]  aFlags       Flags modifying the behavior of this function,
   *                          See enum #ImportImageFlags.  ii_keep_aspect_ratio
   *                          is not needed if @a aZoom is non-zero.
   *
   * @return rc_ok if successful.
   *
   * @see importPageFromImageBlob(), addImageFromFile()
   */
  virtual ReturnCode addImageFromBlob (int aTargetPage,
                                       const unsigned char *aPtr, size_t aSize,
                                       double aZoom, double aX, double aY,
                                       double aWidth, double aHeight,
                                       int aFlags) = 0;

  /**
   * @brief Add an image (from a file) to a page.
   *
   * @param[in]  aTargetPage  The 1-based number of the page.
   * @param[in]  aEncoding    The encoding of @a aPath.
   * @param[in]  aPath        The pathname of the file containing the image.
   *                          Supported formats for inserting into PDF
   *                          documents are: JPEG, PNG, GIF, TIFF, and BMP.
   * @param[in]  aZoom        Zoom factor or zero.  If this argument is
   *                          non-zero, @a aWidth and @a aHeight must be
   *                          zero.  The size of the page is computed from
   *                          the image size and resolution, multiplied by
   *                          @a aZoom.
   * @param[in]  aX           The X coordinate of the point at which the
   *                          lower left corner of the image shall be placed.
   * @param[in]  aY           The Y coordinate of the point at which the
   *                          lower left corner of the image shall be placed.
   * @param[in]  aWidth       Image width (document coordinates) or zero.
   *                          If this argument is non-zero, @a aHeight must
   *                          also be non-zero and @a aZoom must be zero.
   *                          The image will be scaled to this width.
   * @param[in]  aHeight      Page height (document coordinates) or zero.
   *                          If this argument is non-zero, @a aWidth must
   *                          also be non-zero and @a aZoom must be zero.
   *                          The image will be scaled to this height.
   * @param[in]  aFlags       Flags modifying the behavior of this function,
   *                          See enum #ImportImageFlags.  ii_keep_aspect_ratio
   *                          is not needed if @a aZoom is non-zero.
   *
   * @return rc_ok if successful.
   *
   * @see importPageFromImageBlob()
   */
  virtual ReturnCode addImageFromFile (int aTargetPage,
                                       de::softpro::doc::Encoding aEncoding,
                                       const std::string &aPath,
                                       double aZoom, double aX, double aY,
                                       double aWidth, double aHeight,
                                       int aFlags) = 0;

  /**
   * @brief Remove pages from the document.
   *
   * A document must have at least page. This function will fail if
   * you attempt to remove all pages.
   *
   * Fields will be removed if all their widgets are on removed pages.
   *
   * Only signatures in signature fields having the SignDocField::f_SinglePage
   * flag set can survive removal of pages.
   *
   * @param[in] aPagesPtr    Pointer to an array of one-based page numbers.
   *                         The order does not matter, neither does the
   *                         number of occurences of a page number.
   * @param[in] aPagesCount  Number of page numbers pointed to by @a aPagesPtr.
   * @param[in] aMode        Tell this function whether to keep or to remove
   *                         the pages specified by @a aPagesPtr.
   *
   * @return rc_ok if successful.
   */
  virtual ReturnCode removePages (const int *aPagesPtr, int aPagesCount,
                                  KeepOrRemove aMode) = 0;

  /**
   * @brief Request to not make changes to the document which are
   *        incompatible with an older version of this class.
   *
   * No features introduced after @a aMajor.@a aMinor will be used.
   *
   * Passing a version number before 1.11 or after the current version
   * will fail.
   *
   * @param[in] aMajor  Major version number.
   * @param[in] aMinor  Minor version number.
   *
   * @return rc_ok if successful.
   */
  virtual ReturnCode setCompatibility (int aMajor, int aMinor) = 0;

  /**
   * @brief Check if the document has unsaved changes.
   *
   * Note that this function might report unsaved changes directly
   * after loading the document if the document is changed during
   * loading by the underlying PDF library.
   *
   * @param[out] aModified   Will be set to true if the document has
   *                         unsaved changes, will be set to false if
   *                         the document does not have unsaved changes.
   *
   * @return rc_ok if successful.
   */
  virtual ReturnCode isModified (bool &aModified) const = 0;

  /**
   * @brief Get an error message for the last function call.
   *
   * @param[in] aEncoding  The encoding to be used for the error message.
   *
   * @return A pointer to a string describing the reason for the
   *         failure of the last function call. The string is empty
   *         if the last call succeeded. The pointer is valid until
   *         this object is destroyed or a member function of this
   *         object is called.
   *
   * @see getErrorMessageW()
   */
  virtual const char *getErrorMessage (de::softpro::doc::Encoding aEncoding) const = 0;

  /**
   * @brief Get an error message for the last function call.
   *
   * @return A pointer to a string describing the reason for the
   *         failure of the last function call. The string is empty
   *         if the last call succeeded. The pointer is valid until
   *         this object is destroyed or a member function of this
   *         object is called.
   *
   * @see getErrorMessage()
   */
  virtual const wchar_t *getErrorMessageW () const = 0;
};

/**
 * @brief Handler for one document type (internal interface).
 */
class SignDocDocumentHandler : private de::softpro::spooc::NonCopyable
{
public:
  /**
   * @brief Constructor.
   *
   * @internal
   */
  SignDocDocumentHandler () { }

  /**
   * @brief Destructor.
   *
   * @internal
   */
  virtual ~SignDocDocumentHandler () { }

  /**
   * @brief Check if a document is supported by this handler.
   *
   * @param[in] aStream  A seekable stream positioned at the first octet
   *                     of the document.
   *
   * @return The type of the document, SignDocDocument::dt_unknown if
   *         the document is not supported.
   *
   * @internal
   */
  virtual SignDocDocument::DocumentType ping (de::softpro::spooc::InputStream &aStream) = 0;

  /**
   * @brief Load a document from memory.
   *
   * @param[in]  aData   Pointer to the first octet of the document.
   * @param[in]  aSize   Size of the document (number of octets).
   * @param[in]  aFontCache  Pointer to a font cache object or NULL.
   *                         Font cache objects are reference counted.
   * @param[in]  aType   Detected document type.
   * @param[out] aError  An error message (UTF-8) must be stored here
   *                     on failure.
   *
   * @return A pointer to a new SignDocDocument object representing the
   *         document, NULL if the document could not be loaded.
   *         The caller is responsible for destroying the object.
   *
   * @see loadFromFile(), ping(), SignDocDocument::copyToStream(), SignDocDocument::saveToFile(), SignDocDocument::saveToStream()
   *
   * @internal
   */
  virtual SignDocDocument *loadFromMemory (const unsigned char *aData,
                                           size_t aSize,
                                           SPFontCache *aFontCache,
                                           SignDocDocument::DocumentType aType,
                                           std::string &aError) = 0;

  /**
   * @brief Load a document from a file.
   *
   * You can open FDF files that reference a PDF file; the referenced
   * PDF file will be opened and the FDF file will be applied to the
   * loaded copy.  If the pathname of the referenced PDF file is not
   * an absolute pathname, it will be interpreted as being relative
   * to the directory containing the FDF file.
   *
   * @param[in]  aPath      Pathname of the document file.
   * @param[in]  aWritable  Open for writing.
   * @param[in]  aFontCache  Pointer to a font cache object or NULL.
   *                         Font cache objects are reference counted.
   * @param[in]  aType       Detected document type.
   * @param[out] aError      An error message (UTF-8) must be stored here
   *                         on failure.
   *
   * @return A pointer to a new SignDocDocument object representing the
   *         document, NULL if the document could not be loaded.
   *         The caller is responsible for destroying the object.
   *
   * @see loadFromMemory(), ping(), SignDocDocument::copyToStream(), SignDocDocument::saveToFile(), SignDocDocument::saveToStream()
   *
   * @internal
   */
  virtual SignDocDocument *loadFromFile (const wchar_t *aPath,
                                         bool aWritable,
                                         SPFontCache *aFontCache,
                                         SignDocDocument::DocumentType aType,
                                         std::string &aError) = 0;
};

/**
 * @brief Create SignDocDocument objects.
 *
 * As the error message is stored in this object, each thread should
 * have its own instance of SignDocDocumentLoader.
 *
 * To be able to load documents, you have to register at least one
 * document handler. There are two ways for registering document
 * handlers:
 *
 * - pass a pointer to a SignDocDocumentHandler object to
 *   registerDocumentHandler()
 * - call registerDocumentHandlerLibrary() to load a document handler DLL
 * .
 */
class SPSDEXPORT1 SignDocDocumentLoader : private de::softpro::spooc::NonCopyable
{
public:
  /**
   * @brief Specify which expiry date shall be used by getRemainingDays().
   */
  enum RemainingDays
  {
    /**
     * @brief Use the expiry date for the product.
     */
    rd_product,

    /**
     * @brief Use the expiry date for signing documents.
     */
    rd_signing
  };

public:
  /**
   * @brief Constructor.
   */
  SignDocDocumentLoader ();

  /**
   * @brief Destructor.
   */
  ~SignDocDocumentLoader ();

  /**
   * @brief Initialize license management.
   *
   * License management must be initialized before
   * SignDocDocument::renderPageAsImage()
   * and SignDocDocument::addSignature()
   * can be used.
   *
   * @param[in] aWho1   The first magic number for the product.
   * @param[in] aWho2   The second magic number for the product.
   *
   * @return true if successful, false on error.
   *
   * @see setLicenseKey()
   */
  static bool initLicenseManager (int aWho1, int aWho2);

  /**
   * @brief Initialize license management with license key.
   *
   * License management must be initialized before
   * SignDocDocument::renderPageAsImage()
   * and SignDocDocument::addSignature()
   * can be used.
   *
   * @param[in] aKeyPtr      Pointer to the first character of the license key.
   * @param[in] aKeySize     Size in octets of the license key.
   * @param[in] aProduct     Must be NULL.
   * @param[in] aVersion     Must be NULL.
   * @param[in] aTokenPtr    NULL or pointer to the first octet of the token.
   *                         Should be NULL.
   * @param[in] aTokenSize   Size in octet of the license key.
   *
   * @return true if successful, false on error.
   *
   * @see initLicenseManager()
   */
  static bool setLicenseKey (const void *aKeyPtr, size_t aKeySize,
                             const char *aProduct, const char *aVersion,
                             const void *aTokenPtr, size_t aTokenSize);

  /**
   * @brief Get the number of days until the license will expire.
   *
   * @param[in]  aWhat  Select which expiry date shall be used
   *                    (rd_product or rd_signing).
   *
   * @return -1 if the license has already expired or is invalid,
   *         0 if the license will expire today,
   *         a positive value for the number of days the license is
   *         still valid. For licenses without expiry date, that
   *         will be several millions of days.
   */
  static int getRemainingDays (RemainingDays aWhat);

  /**
   * @brief Get the installation code needed for creating a license file.
   *
   * @param[out] aCode  The installation code will be stored here.
   *                    Only ASCII characters are used.
   *
   * @return true if successful, false on error.
   */
  static bool getInstallationCode (std::string &aCode);

  /**
   * @brief Get the version number of SignDocShared or SignDoc SDK.
   *
   * @param[out] aVersion  The version number will be stored here.
   *                       It consists of 3 integers separated by
   *                       dots, .e.g.,  "1.16.7"
   *
   * @return true if successful, false on error.
   */
  static bool getVersionNumber (std::string &aVersion);

  /**
   * @brief Get the number of license texts.
   *
   * SignDocSDK includes several Open Source components. You can retrieve
   * the license texts one by one.
   *
   * @return The number of license texts.
   *
   * @see getLicenseText()
   */
  static int getLicenseTextCount ();

  /**
   * @brief Get a license text.
   *
   * SignDocSDK includes several Open Source components. You can retrieve
   * the license texts one by one.
   *
   * @param[in] aIndex  The zero-based index of the license text.
   *
   * @return A pointer to the null-terminated license text. Lines are
   *         terminated by LF characters.  If @a aIndex is invalid,
   *         NULL will be returned.
   *
   * @see getLicenseTextCount()
   */
  static const char *getLicenseText (int aIndex);

  /**
   * @brief Load a document from memory.
   *
   * Signing some types of document may involve writing the document
   * to a file, so using loadFromFile() function may be a better choice.
   *
   * @param[in] aData  Pointer to the first octet of the document.
   *                   This array of octets must live at least as long
   *                   as the returned object.
   * @param[in] aSize  Size of the document (number of octets).
   *
   * @return A pointer to a new SignDocDocument object representing the
   *         document, NULL if the document could not be loaded.
   *         The caller is responsible for destroying the object.
   *
   * @see getErrorMessage(), loadFromFile()
   */
  SignDocDocument *loadFromMemory (const unsigned char *aData, size_t aSize);

  /**
   * @brief Load a document from a file.
   *
   * Signing the document will overwrite the document, but see
   * integer parameter "Optimize" of SignDocSignatureParameters.
   *
   * @param[in] aEncoding  The encoding of the string pointed to
   *                        by @a aPath.
   * @param[in] aPath       Pathname of the document file.
   * @param[in] aWritable   Open for writing (for signing in place)
   *
   * @return A pointer to a new SignDocDocument object representing the
   *         document, NULL if the document could not be loaded.
   *         The caller is responsible for destroying the object.
   *
   * @see getErrorMessage(), loadFromMemory(), SignDocSignatureParameters::setInteger()
   */
  SignDocDocument *loadFromFile (de::softpro::doc::Encoding aEncoding,
                                 const char *aPath, bool aWritable);

  /**
   * @brief Load a document from a file.
   *
   * Signing the document will overwrite the document, but see
   * integer parameter "Optimize" of SignDocSignatureParameters.
   *
   * @param[in] aPath       Pathname of the document file.
   * @param[in] aWritable   Open for writing (for signing in place)
   *
   * @return A pointer to a new SignDocDocument object representing the
   *         document, NULL if the document could not be loaded.
   *         The caller is responsible for destroying the object.
   *
   * @see getErrorMessage(), loadFromMemory(), SignDocSignatureParameters::setInteger()
   */
  SignDocDocument *loadFromFile (const wchar_t *aPath, bool aWritable);

  /**
   * @brief Determine the type of a document.
   *
   * @param[in] aStream  A seekable stream for the document.
   *
   * @return The type of the document, dt_unknown on error.
   *
   * @see getErrorMessage()
   */
  SignDocDocument::DocumentType ping (de::softpro::spooc::InputStream &aStream);

  /**
   * @brief Load font configuration from a file.
   *
   * Suitable fonts are required for putting text containing characters
   * that cannot be encoded using WinAnsiEncoding into text fields,
   * FreeText annotations, and DigSig appearances of PDF documents.
   * See section @ref signdocshared_fontconfig.
   *
   * The font configuration applies to all SignDocDocument objects created
   * by this object.
   *
   * @param[in] aEncoding  The encoding of the string pointed to
   *                        by @a aPath.
   * @param[in] aPath  The pathname of the file.
   *
   * @return true if successful, false on error.
   *
   * @see getFailedFontFiles(), loadFontConfigEnvironment(), loadFontConfigStream()
   */
  bool loadFontConfigFile (de::softpro::doc::Encoding aEncoding,
                           const char *aPath);

  /**
   * @brief Load font configuration from a file.
   *
   * Suitable fonts are required for putting text containing characters
   * that cannot be encoded using WinAnsiEncoding into text fields,
   * FreeText annotations, and DigSig appearances of PDF documents.
   * See section @ref signdocshared_fontconfig.
   *
   * The font configuration applies to all SignDocDocument objects created
   * by this object.
   *
   * @param[in] aPath  The pathname of the file.
   *
   * @return true if successful, false on error.
   *
   * @see getFailedFontFiles(), loadFontConfigEnvironment(), loadFontConfigStream()
   */
  bool loadFontConfigFile (const wchar_t *aPath);

  /**
   * @brief Load font configuration from files specified by an environment variable.
   *
   * Suitable fonts are required for putting text containing characters
   * that cannot be encoded using WinAnsiEncoding into text fields,
   * FreeText annotations, and DigSig appearances of PDF documents.
   * See section @ref signdocshared_fontconfig.
   *
   * Under Windows, directories are separated by semicolons. Under Unix,
   * directories are separated by colons.
   *
   * The font configuration applies to all SignDocDocument objects created
   * by this object.
   *
   * @param[in] aName  The name of the environment variable.
   *
   * @return true if successful, false on error.
   *
   * @see getFailedFontFiles(), loadFontConfigFile(), loadFontConfigStream()
   */
  bool loadFontConfigEnvironment (const char *aName);

  /**
   * @brief Load font configuration from a stream.
   *
   * Suitable fonts are required for putting text containing characters
   * that cannot be encoded using WinAnsiEncoding into text fields,
   * FreeText annotations, and DigSig appearances of PDF documents.
   * See section @ref signdocshared_fontconfig.
   *
   * The font configuration applies to all SignDocDocument objects created
   * by this object.
   *
   * @param[in] aStream    The font configuration will be read from this stream.
   *                       This function reads the input completely, it doesn't
   *                       stop at the end tag.
   * @param[in] aEncoding  The encoding of the string pointed to
   *                       by @a aDirectory.
   * @param[in] aDirectory  If non-NULL, relative font pathnames will be
   *                        relative to this directory. The directory must
   *                        exist and must be readable. If NULL, relative
   *                        font pathnames will make this function fail.
   *
   * @return true if successful, false on error.
   *
   * @see getFailedFontFiles(), loadFontConfigEnvironment(), loadFontConfigFile()
   */
  bool loadFontConfigStream (de::softpro::spooc::InputStream &aStream,
                             de::softpro::doc::Encoding aEncoding,
                             const char *aDirectory);

  /**
   * @brief Load font configuration from a stream.
   *
   * Suitable fonts are required for putting text containing characters
   * that cannot be encoded using WinAnsiEncoding into text fields,
   * FreeText annotations, and DigSig appearances of PDF documents.
   * See section @ref signdocshared_fontconfig.
   *
   * The font configuration applies to all SignDocDocument objects created
   * by this object.
   *
   * @param[in] aStream  The font configuration will be read from this stream.
   *                     This function reads the input completely, it doesn't
   *                     stop at the end tag.
   * @param[in] aDirectory  If non-NULL, relative font pathnames will be
   *                        relative to this directory. The directory must
   *                        exist and must be readable. If NULL, relative
   *                        font pathnames will make this function fail.
   *
   * @return true if successful, false on error.
   *
   * @see getFailedFontFiles(), loadFontConfigEnvironment(), loadFontConfigFile()
   */
  bool loadFontConfigStream (de::softpro::spooc::InputStream &aStream,
                             const wchar_t *aDirectory);

  /**
   * @brief Load font configuration for PDF documents from a file.
   *
   * Additional fonts may be required for rendering PDF documents.
   * The font configuration for PDF documents contains mappings
   * from font names to font files.
   * See section @ref signdocshared_fontconfig.
   * The "embed" attribute is ignored, substitutions with type="forced"
   * are applied before those with type="fallback".
   *
   * The font configuration for PDF documents is global, ie, it
   * affects all PDF documents, no matter by which
   * SignDocDocumentLoader object they have been created.
   *
   * @param[in] aEncoding  The encoding of the string pointed to
   *                        by @a aPath.
   * @param[in] aPath  The pathname of the file.
   *
   * @return true if successful, false on error.
   *
   * @see getFailedFontFiles(), loadPdfFontConfigEnvironment(), loadPdfFontConfigStream()
   */
  bool loadPdfFontConfigFile (de::softpro::doc::Encoding aEncoding,
                              const char *aPath);

  /**
   * @brief Load font configuration for PDF documents from a file.
   *
   * Additional fonts may be required for rendering PDF documents.
   * The font configuration for PDF documents contains mappings
   * from font names to font files.
   * See section @ref signdocshared_fontconfig.
   * The "embed" attribute is ignored, substitutions with type="forced"
   * are applied before those with type="fallback".
   *
   * The font configuration for PDF documents is global, ie, it
   * affects all PDF documents, no matter by which
   * SignDocDocumentLoader object they have been created.
   *
   * @param[in] aPath  The pathname of the file.
   *
   * @return true if successful, false on error.
   *
   * @see getFailedFontFiles(), loadPdfFontConfigEnvironment(), loadPdfFontConfigStream()
   */
  bool loadPdfFontConfigFile (const wchar_t *aPath);

  /**
   * @brief Load font configuration for PDF documents from files
   *        specified by an environment variable.
   *
   * Additional fonts may be required for rendering PDF documents.
   * The font configuration for PDF documents contains mappings
   * from font names to font files.
   * See section @ref signdocshared_fontconfig.
   * The "embed" attribute is ignored, substitutions with type="forced"
   * are applied before those with type="fallback".
   *
   * The font configuration for PDF documents is global, ie, it
   * affects all PDF documents, no matter by which
   * SignDocDocumentLoader object they have been created.
   *
   * Under Windows, directories are separated by semicolons. Under Unix,
   * directories are separated by colons.
   *
   * See section @ref signdocshared_fontconfig.
   * The "embed" attribute is ignored, substitutions with type="forced"
   * are applied before those with type="fallback".
   *
   * @param[in] aName  The name of the environment variable.
   *
   * @return true if successful, false on error.
   *
   * @see getFailedFontFiles(), loadPdfFontConfigFile(), loadPdfFontConfigStream()
   */
  bool loadPdfFontConfigEnvironment (const char *aName);

  /**
   * @brief Load font configuration for PDF documents from a stream.
   *
   * Additional fonts may be required for rendering PDF documents.
   * The font configuration for PDF documents contains mappings
   * from font names to font files.
   * See section @ref signdocshared_fontconfig.
   * The "embed" attribute is ignored, substitutions with type="forced"
   * are applied before those with type="fallback".
   *
   * The font configuration for PDF documents is global, ie, it
   * affects all PDF documents, no matter by which
   * SignDocDocumentLoader object they have been created.
   *
   * @param[in] aStream    The font configuration will be read from this stream.
   *                       This function reads the input completely, it doesn't
   *                       stop at the end tag.
   * @param[in] aEncoding  The encoding of the string pointed to
   *                       by @a aDirectory.
   * @param[in] aDirectory  If non-NULL, relative font pathnames will be
   *                        relative to this directory. The directory must
   *                        exist and must be readable. If NULL, relative
   *                        font pathnames will make this function fail.
   *
   * @return true if successful, false on error.
   *
   * @see getFailedFontFiles(), loadPdfFontConfigEnvironment(), loadPdfFontConfigFile()
   */
  bool loadPdfFontConfigStream (de::softpro::spooc::InputStream &aStream,
                                de::softpro::doc::Encoding aEncoding,
                                const char *aDirectory);

  /**
   * @brief Load font configuration for PDF documents from a stream.
   *
   * Additional fonts may be required for rendering PDF documents.
   * The font configuration for PDF documents contains mappings
   * from font names to font files.
   * See section @ref signdocshared_fontconfig.
   * The "embed" attribute is ignored, substitutions with type="forced"
   * are applied before those with type="fallback".
   *
   * The font configuration for PDF documents is global, ie, it
   * affects all PDF documents, no matter by which
   * SignDocDocumentLoader object they have been created.
   *
   * @param[in] aStream  The font configuration will be read from this stream.
   *                     This function reads the input completely, it doesn't
   *                     stop at the end tag.
   * @param[in] aDirectory  If non-NULL, relative font pathnames will be
   *                        relative to this directory. The directory must
   *                        exist and must be readable. If NULL, relative
   *                        font pathnames will make this function fail.
   *
   * @return true if successful, false on error.
   *
   * @see getFailedFontFiles(), loadPdfFontConfigEnvironment(), loadPdfFontConfigFile()
   */
  bool loadPdfFontConfigStream (de::softpro::spooc::InputStream &aStream,
                                const wchar_t *aDirectory);

  /**
   * @brief Get the pathnames of font files that failed to load for
   *        the most recent loadFontConfig*() or loadPdfFontConfig*()
   *        call.
   *
   * This includes files that could not be found and files that could
   * not be loaded. In the former case, the pathname may contain
   * wildcard characters.
   *
   * Note that loadFontConfig*() and loadPdfFontConfig() no longer
   * fail if a specified font file cannot be found or loaded.
   *
   * @param[out] aOutput  The pathnames will be stored here.
   *
   * @see loadFontConfigEnvironment(), loadFontConfigFile(), loadFontConfigStream(), loadPdfFontConfigEnvironment(), loadPdfFontConfigFile(), loadPdfFontConfigStream()
   */
  void getFailedFontFiles (std::vector<std::string> &aOutput);

  /**
   * @brief Get an error message for the last load*() or ping() call.
   *
   * @param[in] aEncoding  The encoding to be used for the error message.
   *
   * @return A pointer to a string describing the reason for the
   *         failure of the last call of load*() or ping(). The string is empty
   *         if the last call succeeded. The pointer is valid until
   *         this object is destroyed or a member function of this
   *         object is called.
   *
   * @see getErrorMessageW(), loadFontConfigEnvironment(), loadFontConfigFile(), loadFontConfigStream(), loadFontConfigStream(), loadFromFile(), loadFromMemory(), loadPdfFontConfigEnvironment(), loadPdfFontConfigFile(), loadPdfFontConfigStream(), ping()
   */
  const char *getErrorMessage (de::softpro::doc::Encoding aEncoding) const;

  /**
   * @brief Get an error message for the last load() or ping() call.
   *
   * @return A pointer to a string describing the reason for the
   *         failure of the last call of load() or ping(). The string is empty
   *         if the last call succeeded. The pointer is valid until
   *         this object is destroyed or a member function of this
   *         object is called.
   *
   * @see getErrorMessage(), load(), ping()
   */
  const wchar_t *getErrorMessageW () const;

  /**
   * @brief Register a document handler.
   *
   * The behavior is undefined if multiple handlers for the same
   * document type are registered.
   *
   * @param[in] aHandler  An instance of a document handler. This object
   *                      takes ownerswhip of the object.
   *
   * @return true iff successful.
   */
  bool registerDocumentHandler (SignDocDocumentHandler *aHandler);

  /**
   * @brief Register a document handler DLL.
   *
   * The DLL must export a function named SignDocCreateDocumentHandler_1
   * which creates an object implementing SignDocDocumentHandler:
   * @code
   * SignDocDocumentHandler *SignDocCreateDocumentHandler_1();
   * @endcode
   * The DLL must use the same heap as the module (DLL or EXE) using the
   * registered document handler.
   *
   * The behavior is undefined if multiple handlers for the same
   * document type are registered.
   *
   * @param[in] aEncoding  The encoding of the string pointed to
   *                        by @a aName.
   * @param[in] aName  The name or pathname of the DLL.
   *
   * @return true iff successful.
   */
  bool registerDocumentHandlerLibrary (de::softpro::doc::Encoding aEncoding,
                                       const char *aName);

  /**
   * @brief Register a document handler DLL.
   *
   * The DLL must export a function named SignDocCreateDocumentHandler_1
   * which creates an object implementing SignDocDocumentHandler:
   * @code
   * SignDocDocumentHandler *SignDocCreateDocumentHandler_1();
   * @endcode
   * The DLL must use the same heap as the module (DLL or EXE) using the
   * registered document handler.
   *
   * The behavior is undefined if multiple handlers for the same
   * document type are registered.
   *
   * @param[in] aName  The name or pathname of the DLL.
   *
   * @return true iff successful.
   */
  bool registerDocumentHandlerLibrary (const wchar_t *aName);

private:
  class Impl;
  Impl *p;
};

/**
 * @brief Information about a signature field returned by
 * SignDocDocument::verifySignature().
 */
class SignDocVerificationResult
{
public:
  /**
   * @brief Return codes.
   *
   * Do not forget to update de/softpro/doc/SignDocException.java!
   */
  enum ReturnCode
  {
    rc_ok = SignDocDocument::rc_ok, ///< No error
    rc_invalid_argument = SignDocDocument::rc_invalid_argument, ///< Invalid argument
    rc_not_supported = SignDocDocument::rc_not_supported, ///< Operation not supported
    rc_not_verified = SignDocDocument::rc_not_verified, ///< SignDocDocument::verifySignature() has not been called
    rc_no_biometric_data = SignDocDocument::rc_no_biometric_data, ///< No biometric data (or hash) available
    rc_unexpected_error = SignDocDocument::rc_unexpected_error ///< Unexpected error
  };

  /**
   * @brief State of a signature.
   */
  enum SignatureState
  {
    ss_unmodified,            ///< No error, signature and document verified.
    ss_document_extended,     ///< No error, signature and document verified, document modified by adding data to the signed document.
    ss_document_modified,     ///< Document modified (possibly forged).
    ss_unsupported_signature, ///< Unsupported signature method.
    ss_invalid_certificate,   ///< Invalid certificate.
    ss_empty                  ///< Signature field without signature.
  };

  /**
   * @brief State of the RFC 3161 time stamp.
   */
  enum TimeStampState
  {
    tss_valid,                ///< No error, an RFC 3161 time stamp is present and valid (but you have to check the certificate chain and revocation).
    tss_missing,              ///< There is no RFC 3161 time stamp.
    tss_invalid               ///< An RFC 3161 time stamp is present but invalid.
  };

  /**
   * @brief Policy for verification of the certificate chain.
   *
   * @see verifyCertificateSimplified(), verifyTimeStampCertificateSimplified()
   */
  enum CertificateChainVerificationPolicy
  {
    /**
     * @brief Don't verify the certificate chain.
     *
     * Always pretend that the certificate chain is OK.
     */
    ccvp_dont_verify,

    /**
     * @brief Accept self-signed certificates.
     *
     * If the signing certificate is not self-signed, it must chain up
     * to a trusted root certificate.
     */
    ccvp_accept_self_signed,

    /**
     * @brief Accept self-signed certificates if biometric data is present.
     *
     * If the signing certificate is not self-signed or if there is no
     * biometric data, the certificate must chain up to a trusted root
     * certificate.
     */
    ccvp_accept_self_signed_with_bio,

    /**
     * @brief Accept self-signed certificates if asymmetrically encrypted
     *        biometric data is present.
     *
     * If the signing certificate is not self-signed or if there is no
     * biometric data or if the biometric data is not encrypted with
     * RSA, the certificate must chain up to a trusted root
     * certificate.
     */
    ccvp_accept_self_signed_with_rsa_bio,

    /**
     * @brief Require a trusted root certificate.
     *
     * The signing certificate must chain up to a trusted root
     * certificate.
     */
    ccvp_require_trusted_root
  };

  /**
   * @brief Policy for verification of certificate revocation.
   *
   * @see verifyCertificateSimplified(), verifyTimeStampCertificateSimplified()
   */
  enum CertificateRevocationVerificationPolicy
  {
    /**
     * @brief Don't verify revocation of certificates.
     *
     * Always pretend that certificates have not been revoked.
     */
    crvp_dont_check,

    /**
     * @brief Check revocation, assume that certificates are not revoked
     *        if the revocation server is offline.
     */
    crvp_offline,

    /**
     * @brief Check revocation, assume that certificates are revoked
     *        if the revocation server is offline.
     */
    crvp_online
  };

  /**
   * @brief Certificate verification model.
   *
   * @see verifyCertificateRevocation(), verifyCertificateSimplified(), verifyTimeStampCertificateChain(), verifyTimeStampCertificateRevocation(), verifyTimeStampCertificateSimplified()
   */
  enum VerificationModel
  {
    /**
     * @brief Whatever the Windows Crypto API or OpenSSL implements.
     */
    vm_windows,

    /**
     * @brief As specfified by German law.
     *
     * @todo implement this
     * @todo name that law
     */
    vm_german_sig_law
  };

  /**
   * @brief Certificate chain state for verifyCertificateChain()
   *        and verifyTimeStampCertificateChain().
   */
  enum CertificateChainState
  {
    ccs_ok,                   ///< Chain OK
    ccs_broken_chain,         ///< Chain broken
    ccs_untrusted_root,       ///< Untrusted root certificate
    ccs_critical_extension,   ///< A certificate has an unknown critical extension
    ccs_not_time_valid,       ///< A certificate is not yet valid or is expired
    ccs_path_length,          ///< Path length constraint not satisfied
    ccs_invalid,              ///< Invalid certificate or chain
    ccs_error                 ///< Other error
  };

  /**
   * @brief Certificate revocation state for verifyCertificateRevocation()
   *        and verifyTimeStampCertificateRevocation().
   */
  enum CertificateRevocationState
  {
    crs_ok,                     ///< No certificate revoked
    crs_not_checked,            ///< Revocation not checked
    crs_offline,                ///< Revocation server is offline
    crs_revoked,                ///< At least one certificate has been revoked
    crs_error                   ///< Error
  };

public:
  /**
   * @brief Constructor.
   */
  SignDocVerificationResult () { }

  /**
   * @brief Destructor.
   */
  virtual ~SignDocVerificationResult () { }

  /**
   * @brief Get the signature state.
   *
   * If the state is ss_unsupported_signature or
   * ss_invalid_certificate, getErrorMessage() will provide additional
   * information.
   *
   * @param[out]  aOutput  The signature state.
   *
   * @return rc_ok if successful.
   *
   * @see getErrorMessage(), SignDocDocument::verifySignature()
   */
  virtual ReturnCode getState (SignatureState &aOutput) = 0;

  /**
   * @brief Get the signing method.
   *
   * @param[out]  aOutput  The signing method.
   *
   * @return rc_ok if successful, rc_not_verified if verification has failed.
   */
  virtual ReturnCode getMethod (SignDocSignatureParameters::Method &aOutput) = 0;

  /**
   * @brief Get the message digest algorithm of the signature.
   *
   * @param[out]  aOutput  The message digest algorithm (such as "SHA-1")
   *                       will be stored here.  If the message digest
   *                       algorithm is unsupported, an empty string will
   *                       be stored.
   *
   * @return rc_ok if successful, rc_not_verified if verification has failed.
   */
  virtual ReturnCode getDigestAlgorithm (std::string &aOutput) = 0;

  /**
   * @brief Get the certificates of the signature.
   *
   * @param[out]  aOutput  The ASN.1-encoded X.509 certificates will be
   *                       stored here.  If there are multiple certificates,
   *                       the first one (at index 0) is the signing
   *                       certificate.
   *
   * @return rc_ok if successful, rc_not_verified if verification has failed.
   */
  virtual ReturnCode getCertificates (std::vector<std::vector<unsigned char> > &aOutput) = 0;

  /**
   * @brief Verify the certificate chain of the signature's certificate.
   *
   * Currently, this function supports PKCS #7 signatures only.
   * getErrorMessage() will return an error message if this function
   * fails (return value not rc_ok) or the verification result returned
   * in @a aOutput is not ccs_ok.
   *
   * @param[in]   aModel   Model to be used for verification.
   * @param[out]  aOutput  The result of the certificate chain verification.
   *
   * @return rc_ok if successful, rc_not_verified if verification has failed.
   *
   * @see getCertificateChainLength(), verifyCertificateRevocation(), verifyCertificateSimplified()
   *
   * @todo support vm_german_sig_law for @a aModel
   */
  virtual ReturnCode verifyCertificateChain (VerificationModel aModel,
                                             CertificateChainState &aOutput) = 0;

  /**
   * @brief Check the revocation status of the certificate chain of the
   *        signature's certificate.
   *
   * verifyCertificateChain() or verifyCertificateSimplified() must
   * have been called successfully.
   *
   * Currently, this function supports PKCS #7 signatures only.
   * getErrorMessage() will return an error message if this function
   * fails (return value not rc_ok) or the verification result returned
   * in @a aOutput is not crs_ok.
   *
   * @param[in]   aModel   Model to be used for verification.
   * @param[out]  aOutput  The result of the certificate revocation check.
   *
   * @return rc_ok if successful, rc_not_verified if verification has failed.
   *
   * @see getCertificateChainLength(), verifyCertificateChain(), verifyCertificateSimplified()
   *
   * @todo support vm_german_sig_law for @a aModel
   */
  virtual ReturnCode verifyCertificateRevocation (VerificationModel aModel,
                                                  CertificateRevocationState &aOutput) = 0;

  /**
   * @brief Simplified verification of the certificate chain and revocation
   *        status of the signature's certificate.
   *
   * This function just returns a good / not good value according to
   * policies defined by the arguments. It does not tell the caller
   * what exactly is wrong. However, getErrorMessage() will return an
   * error message if this function fails. Do not attempt to base
   * decisions on that error message, please use verifyCertificateChain()
   * and verifyCertificateRevocation() instead of this function if
   * you need details about the failure.
   *
   * If @a aChainPolicy is ccvp_dont_verify, @a aRevocationPolicy must
   * be crvp_dont_check, otherwise this function will return
   * rc_invalid_argument.
   *
   * Currently, only self-signed certificates are supported for PKCS
   * #1, therefore ccvp_require_trusted_root always makes this
   * function fail for PKCS #1 signatures.  crvp_online and crvp_offline
   * also make this function fail for PKCS #1 signatures.
   *
   * @param[in] aChainPolicy       Policy for verification of the certificate
   *                               chain.
   * @param[in] aRevocationPolicy  Policy for verification of the revocation
   *                               status of the certificates.
   * @param[in] aModel             Model to be used for verification.
   *
   * @return rc_ok if successful, rc_not_verified if verification has failed,
   *         rc_invalid_argument if the arguments are invalid.
   *
   * @see getCertificateChainLength(), verifyCertificateChain(), verifyCertificateRevocation()
   *
   * @todo support vm_german_sig_law for @a aModel
   */
  virtual ReturnCode verifyCertificateSimplified (CertificateChainVerificationPolicy aChainPolicy,
                                                  CertificateRevocationVerificationPolicy aRevocationPolicy,
                                                  VerificationModel aModel) = 0;

  /**
   * @brief Get the certificate chain length.
   *
   * verifyCertificateChain() or verifyCertificateSimplified() must
   * have been called successfully.
   *
   * Currently, this function supports PKCS #7 signatures only.
   *
   * @param[out]  aOutput  The chain length will be stored here if this
   *                       function is is successful.  If the signature was
   *                       performed with a self-signed certificate, the
   *                       chain length will be 1.
   *
   * @return rc_ok if successful, rc_not_verified if verification has failed.
   *
   * @see verifyCertificateChain(), verifyCertificateSimplified()
   */
  virtual ReturnCode getCertificateChainLength (int &aOutput) = 0;

  /**
   * @brief Get a string parameter from the signature field.
   *
   * Available string parameters are:
   * - ContactInfo         The contact information provided by the signer.
   * - Filter              The name of the preferred filter.
   * - Location            The host name or physical location of signing.
   * - Reason              The reason for the signing.
   * - Signer              The signer.
   * - Timestamp           The timestamp of the signature in ISO 8601 format:
   *                       "yyyy-mm-ddThh:mm:ss" with optional timezone.
   *                       Note that the timestamp can alternatively
   *                       be stored in the PKCS #7 message, see getTimeStamp().
   * .
   *
   * @param[in]   aEncoding   The encoding to be used for @a aOutput.
   * @param[in]   aName    The name of the parameter.
   * @param[out]  aOutput  The string retrieved from the signature field.
   *
   * @return rc_ok if successful, rc_not_verified if verification has failed.
   *
   * @see getTimeStamp(), SignDocDocument::getLastTimestamp(), SignDocSignatureParameters::setString()
   *
   * @todo document which parameters are available for which methods
   */
  virtual ReturnCode getSignatureString (de::softpro::doc::Encoding aEncoding,
                                         const std::string &aName,
                                         std::string &aOutput) = 0;

  /**
   * @brief Get the biometric data of the field.
   *
   * Use getBiometricEncryption() to find out what parameters need to
   * be passed:
   * - be_rsa        Either @a aKeyPtr or @a aKeyPath must be non-NULL,
   *                 @a aPassphrase is required if the key file is encrypted
   * - be_fixed      @a aKeyPtr, @a aKeyPath, and @a aPassphrase must be NULL
   * - be_binary     @a aKeyPtr must be non-NULL, @a aKeySize must be 32,
   *                 @a aPassphrase must be NULL
   * - be_passphrase @a aKeyPtr must point to the passphrase (which should
   *                 contain ASCII characters only), @a aPassphrase
   *                 must be NULL
   * .
   * @note Don't forget to overwrite the biometric data in memory after use!
   *
   * @param[in]  aKeyPtr      Pointer to the first octet of the key (must
   *                          be NULL if @a aKeyPath is not NULL).
   * @param[in]  aKeySize     Size of the key pointed to by @a aKeyPtr (must
   *                          be 0 if @a aKeyPath is not NULL).
   * @param[in]  aKeyPath     Pathname of the file containing the key (must
   *                          be NULL if @a aKeyPtr is not NULL).
   * @param[in]  aPassphrase  Passphrase for decrypting the key contained in
   *                          the file named by @a aKeyPath.  If this argument
   *                          is NULL or points to the empty string, it will
   *                          be assumed that the key file is not protected
   *                          by a passphrase.  @a aPassphrase is used only
   *                          when reading the key from a file for
   *                          @ref SignDocSignatureParameters::be_rsa.
   *                          The passphrase must contain ASCII characters
   *                          only.
   * @param[out] aOutput      The decrypted biometric data will be stored here.
   *
   * @return rc_ok if successful, rc_no_biometric_data if no biometric
   *         data is availabable.
   *
   * @see checkBiometricHash(), getBiometricEncryption(), getEncryptedBiometricData()
   */
  virtual ReturnCode getBiometricData (const unsigned char *aKeyPtr,
                                       size_t aKeySize,
                                       const wchar_t *aKeyPath,
                                       const char *aPassphrase,
                                       std::vector<unsigned char> &aOutput) = 0;

  /**
   * @brief Get the biometric data of the field.
   *
   * Use getBiometricEncryption() to find out what parameters need to
   * be passed:
   * - be_rsa        Either @a aKeyPtr or @a aKeyPath must be non-NULL,
   *                 @a aPassphrase is required if the key file is encrypted
   * - be_fixed      @a aKeyPtr, @a aKeyPath, and @a aPassphrase must be NULL
   * - be_binary     @a aKeyPtr must be non-NULL, @a aKeySize must be 32,
   *                 @a aPassphrase must be NULL
   * - be_passphrase @a aKeyPtr must point to the passphrase (which should
   *                 contain ASCII characters only), @a aPassphrase
   *                 must be NULL
   * .
   * @note Don't forget to overwrite the biometric data in memory after use!
   *
   * @param[in]  aEncoding    The encoding of the string pointed to
   *                          by @a aKeyPath.
   * @param[in]  aKeyPtr      Pointer to the first octet of the key (must
   *                          be NULL if @a aKeyPath is not NULL).
   * @param[in]  aKeySize     Size of the key pointed to by @a aKeyPtr (must
   *                          be 0 if @a aKeyPath is not NULL).
   * @param[in]  aKeyPath     Pathname of the file containing the key (must
   *                          be NULL if @a aKeyPtr is not NULL).
   * @param[in]  aPassphrase  Passphrase for decrypting the key contained in
   *                          the file named by @a aKeyPath.  If this argument
   *                          is NULL or points to the empty string, it will
   *                          be assumed that the key file is not protected
   *                          by a passphrase.  @a aPassphrase is used only
   *                          when reading the key from a file for
   *                          @ref SignDocSignatureParameters::be_rsa.
   *                          The passphrase must contain ASCII characters
   *                          only.
   * @param[out] aOutput      The decrypted biometric data will be stored here.
   *
   * @return rc_ok if successful, rc_no_biometric_data if no biometric
   *         data is availabable.
   *
   * @see checkBiometricHash(), getBiometricEncryption(), getEncryptedBiometricData()
   */
  virtual ReturnCode getBiometricData (de::softpro::doc::Encoding aEncoding,
                                       const unsigned char *aKeyPtr,
                                       size_t aKeySize,
                                       const char *aKeyPath,
                                       const char *aPassphrase,
                                       std::vector<unsigned char> &aOutput) = 0;

  /**
   * @brief Get the encrypted biometric data of the field.
   *
   * Use this function if you cannot use getBiometricData() for
   * decrypting the biometric data (for instance, because the private
   * key is stored in an HSM).
   *
   * In the following description of the format of the encrypted data
   * retrieved by this function, all numbers are stored in little-endian
   * format (howver, RSA uses big-endian format):
   *
   * - 4 octets: version number
   * - 4 octets: number of following octets (hash and body)
   * - 32 octets: SHA-256 hash of body (ie, of the octets which follow)
   * - body (format depends on version number)
   * .
   *
   * If the version number is 1, the encryption method is be_rsa with
   * a 2048-bit key and the body has this format:
   *
   * - 32 octets: SHA-256 hash of unencrypted biometric data
   * - 256 octets: AES-256 session key encrypted with 2048-bit RSA 2.0 (OAEP)
   *               with SHA-256
   * - rest: biometric data encrypted with AES-256 in CBC mode using
   *         padding as described in RFC 2246. The IV is zero (not a
   *         problem as the session key is random).
   * .
   * 
   * If the version number is 2, the body has this format:
   *
   * - 4 octets: method (be_fixed, be_binary, be_passphrase)
   * - 32 octets: IV
   * - 32 octets: SHA-256 hash of unencrypted biometric data
   * - rest: biometric data encrypted with AES-256 in CBC mode using
   *         padding as described in RFC 2246.
   * .
   *
   * If the version number is 3, the encryption method is be_rsa with
   * a key longer than 2048 bits and the body has this format:
   *
   * - 4 octets: size n of encrypted AES key in octets
   * - n octets: AES-256 session key encrypted with RSA 2.0 (OAEP)
   *             with SHA-256
   * - 32 octets: IV
   * - 32 octets: SHA-256 hash of unencrypted biometric data
   * - rest: biometric data encrypted with AES-256 in CBC mode using
   *         padding as described in RFC 2246.
   * .
   *
   * @param[out] aOutput      The decrypted biometric data will be stored here.
   *                          See above for the format.
   *
   * @return rc_ok if successful, rc_no_biometric_data if no biometric
   *         data is availabable.
   *
   * @see checkBiometricHash(), getBiometricData(), getBiometricEncryption()
   */
  virtual ReturnCode getEncryptedBiometricData (std::vector<unsigned char> &aOutput) = 0;

  /**
   * @brief Get the encryption method used for biometric data of the signature
   *        field.
   *
   * @param[out] aOutput     The encryption method.
   *
   * @return rc_ok if successful, rc_no_biometric_data if no biometric
   *         data is availabable.
   *
   * @see getBiometricData(), getEncryptedBiometricData()
   */
  virtual ReturnCode getBiometricEncryption (SignDocSignatureParameters::BiometricEncryption &aOutput) = 0;

  /**
   * @brief Check the hash of the biometric data.
   *
   * @param[in]  aBioPtr        Pointer to unencrypted biometric data,
   *                            typically retrieved by getBiometricData().
   * @param[in]  aBioSize       Size of unencrypted biometric data in octets.
   * @param[out] aOutput        Result of the operation: true if the hash is
   *                            OK, false if the hash doesn't match (the
   *                            document has been tampered with).
   * @see getBiometricData(), getEncryptedBiometricData()
   */
  virtual ReturnCode checkBiometricHash (const unsigned char *aBioPtr,
                                         size_t aBioSize, bool &aOutput) = 0;

  /**
   * @brief Get the state of the RFC 3161 time stamp.
   *
   * @param[out]  aOutput  The state of the RFC 3161 time stamp.
   *
   * @return rc_ok if successful.
   */
  virtual ReturnCode getTimeStampState (TimeStampState &aOutput) = 0;

  /**
   * @brief Verify the certificate chain of the RFC 3161 time stamp.
   *
   * getErrorMessage() will return an error message if this function
   * fails (return value not rc_ok) or the verification result returned
   * in @a aOutput is not ccs_ok.
   *
   * @param[in]   aModel   Model to be used for verification.
   * @param[out]  aOutput  The result of the certificate chain verification.
   *
   * @return rc_ok if successful, rc_not_verified if verification has failed.
   *
   * @see verifyTimeStampCertificateRevocation(), verifyTimeStampCertificateSimplified()
   *
   * @todo support vm_german_sig_law for @a aModel
   */
  virtual ReturnCode verifyTimeStampCertificateChain (VerificationModel aModel,
                                                      CertificateChainState &aOutput) = 0;

  /**
   * @brief Check the revocation status of the certificate chain of the
   *        RFC 3161 time stamp.
   *
   * getErrorMessage() will return an error message if this function
   * fails (return value not rc_ok) or the verification result returned
   * in @a aOutput is not crs_ok.
   *
   * @param[in]   aModel   Model to be used for verification.
   * @param[out]  aOutput  The result of the certificate revocation check.
   *
   * @return rc_ok if successful, rc_not_verified if verification has failed.
   *
   * @see verifyTimeStampCertificateChain(), verifyTimeStampCertificateSimplified()
   *
   * @todo support vm_german_sig_law for @a aModel
   */
  virtual ReturnCode verifyTimeStampCertificateRevocation (VerificationModel aModel,
                                                           CertificateRevocationState &aOutput) = 0;

  /**
   * @brief Simplified verification of the certificate chain and revocation
   *        status of the RFC 3161 time stamp.
   *
   * This function just returns a good / not good value according to
   * policies defined by the arguments. It does not tell the caller
   * what exactly is wrong. However, getErrorMessage() will return an
   * error message if this function fails. Do not attempt to base
   * decisions on that error message, please use
   * verifyTimeStampCertificateChain() and
   * verifyTimeStampCertificateRevocation() instead of this function
   * if you need details about the failure.
   *
   * If @a aChainPolicy is ccvp_dont_verify, @a aRevocationPolicy must
   * be crvp_dont_check, otherwise this function will return
   * rc_invalid_argument.
   *
   * @a ccvp_accept_self_signed_with_bio and
   * @a ccvp_accept_self_signed_with_rsa_bio are treated like
   * @a ccvp_accept_self_signed.
   *
   * @param[in] aChainPolicy       Policy for verification of the certificate
   *                               chain.
   * @param[in] aRevocationPolicy  Policy for verification of the revocation
   *                               status of the certificates.
   * @param[in] aModel             Model to be used for verification.
   *
   * @return rc_ok if successful, rc_not_verified if verification has failed,
   *         rc_invalid_argument if the arguments are invalid,
   *         rc_not_supported if there is no RFC 3161 time stamp.
   *
   * @see verifyTimeStampCertificateChain(), verifyTimeStampCertificateRevocation()
   *
   * @todo support vm_german_sig_law for @a aModel
   */
  virtual ReturnCode verifyTimeStampCertificateSimplified (CertificateChainVerificationPolicy aChainPolicy,
                                                           CertificateRevocationVerificationPolicy aRevocationPolicy,
                                                           VerificationModel aModel) = 0;

  /**
   * @brief Get the value of the RFC 3161 time stamp.
   *
   * You must call verifyTimeStampCertificateChain() and
   * verifyTimeStampCertificateRevocation() to find out whether
   * the time stamp can be trusted.  If either of these functions
   * report a problem, the time stamp should not be displayed.
   *
   * A signature has either an RFC 3161 time stamp (returned by this
   * function) or a time stamp stored as string parameter (returned by
   * getSignatureString().
   *
   * @param[out]  aOutput  The RFC 3161 time stamp in ISO 8601
   *                       format: "yyyy-mm-ddThh:mm:ssZ"
   *                       (without milliseconds).
   *
   * @return rc_ok if successful.
   *
   * @see getSignatureString(), verifyTimeStampCertificateChain(), verifyTimeStampCertificateRevocation()
   */
  virtual ReturnCode getTimeStamp (std::string &aOutput) = 0;

  /**
   * @brief Get the certificates of the RFC 3161 time stamp.
   *
   * @param[out]  aOutput  The ASN.1-encoded X.509 certificates will be
   *                       stored here.  If there are multiple certificates,
   *                       the first one (at index 0) is the signing
   *                       certificate.
   *
   * @return rc_ok if successful, rc_not_verified if verification has failed.
   */
  virtual ReturnCode getTimeStampCertificates (std::vector<std::vector<unsigned char> > &aOutput) = 0;

  /**
   * @brief Get an error message for the last function call.
   *
   * @param[in] aEncoding  The encoding to be used for the error message.
   *
   * @return A pointer to a string describing the reason for the
   *         failure of the last function call. The string is empty
   *         if the last call succeeded. The pointer is valid until
   *         this object is destroyed or a member function of this
   *         object is called.
   *
   * @see getErrorMessageW()
   */
  virtual const char *getErrorMessage (de::softpro::doc::Encoding aEncoding) const = 0;

  /**
   * @brief Get an error message for the last function call.
   *
   * @return A pointer to a string describing the reason for the
   *         failure of the last function call. The string is empty
   *         if the last call succeeded. The pointer is valid until
   *         this object is destroyed or a member function of this
   *         object is called.
   *
   * @see getErrorMessage()
   */
  virtual const wchar_t *getErrorMessageW () const = 0;
};

#undef SPSDEXPORT1

#endif
